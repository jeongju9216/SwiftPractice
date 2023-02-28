//
//  ViewController.swift
//  CarouselCollectionView
//
//  Created by 유정주 on 2023/02/12.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let itemSize: CGFloat = 180
    private let list = (1...10).map { $0 }
    var oneCycleWidth: CGFloat = 0
    
    var scrollCount: CGFloat = 0, preScrollX: CGFloat = 0

    enum Section: Int, CaseIterable {
        case Main
    }
        
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Model>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Model>
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()

    var dataSource: DataSource?

    private var goFirstTimeStamp: TimeInterval = Date().timeIntervalSinceNow
    private var goLastTimeStamp: TimeInterval = Date().timeIntervalSince1970
    
    var skipCount: Int = 0
    
    var scrollPosition: CGFloat = 0
    var cancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.configureView()
        self.configureCollectionView()
        self.configureDataSource()
        self.configureSnapShot()
        
        collectionView.delegate = self
        
//        self.startTimer()
        
        oneCycleWidth = CGFloat(self.list.count) * self.itemSize
        print("oneCycleWidth: \(oneCycleWidth)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func startTimer() {
        cancellable = Timer.publish(every: 0.1, on: .current, in: .default)
            .autoconnect()
            .sink { [weak self] receiveValue in
                guard let self = self else { return }
                
                let newOffset = CGPoint(x: self.collectionView.contentOffset.x + 1, y: self.collectionView.contentOffset.y)
                
                self.collectionView.setContentOffset(newOffset, animated: true)
            }
    }
    
    private func autoScroll() {
//        scrollPosition += 10
        let newOffset = CGPoint(x: self.collectionView.contentOffset.x + 10, y: self.collectionView.contentOffset.y)
        
        self.collectionView.setContentOffset(newOffset, animated: true)
    }

    private func bindSnapShotApply(section: Section, item: [Model]) {
        DispatchQueue.global().sync {
            guard var snapShot = self.dataSource?.snapshot() else { return }
            
            item.forEach {
                snapShot.appendItems([$0], toSection: section)
            }
            
            self.dataSource?.apply(snapShot, animatingDifferences: true) { [weak self] in
                self?.collectionView.scrollToItem(at: [0, 0],
                                                  at: .left,
                                                  animated: false)
            }
        }
    }

    private func configureSnapShot() {
        var snapShot = Snapshot()
        
        snapShot.appendSections([.Main])
        
        self.dataSource?.apply(snapShot, animatingDifferences: true)
        
        var listItem: [Model] = []
        var count: Int = 0
        for _ in 0..<3 {
            for item in list {
                listItem.append(Model(number: item))
                count += 1
            }
        }
        
        self.bindSnapShotApply(section: .Main, item: listItem)
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = self.configureCompositionalLayout()
        
        self.collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
    }
    
    private func configureDataSource() {
        let datasource = DataSource(collectionView: self.collectionView, cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell else {
                return UICollectionViewCell()
            }
            
            cell.updateView(item: item)
            
            return cell
        })
        
        self.dataSource = datasource
        self.collectionView.dataSource = datasource
    }
    
    private func configureView() {
        self.view.addSubview(self.collectionView)
        
        self.collectionView.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionNumber, env) -> NSCollectionLayoutSection? in
            guard let self = self else { return .list(using: .init(appearance: .plain), layoutEnvironment: env) }
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(self.itemSize),
                                                                heightDimension: .absolute(self.itemSize)))
            item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(self.itemSize),
                                                                             heightDimension: .absolute(self.itemSize)),
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            section.visibleItemsInvalidationHandler = { [weak self] (item, offset, env) in
                guard let self = self else { return }
                
                //                let index = Int(ceil(offset.x / env.container.contentSize.width))
                
                self.skipScroll(offsetX: offset.x)
            }
            
            return section
        }
    }
    
    private func skipScroll(offsetX: CGFloat) {
        let diff = offsetX - preScrollX
        
        self.preScrollX = offsetX
        
        let scrollCheckTime = Date().timeIntervalSince1970

        if abs(scrollCheckTime - goFirstTimeStamp) > 1 && abs(scrollCheckTime - goLastTimeStamp) > 1 {
            self.scrollCount += diff
        }
        print("scrollCount: \(scrollCount) / skipCount: \(skipCount)")

        if diff > 0 {
            if offsetX - itemSize >= oneCycleWidth * 2 {
//                print("Check GO First")
                let newTimeStamp = Date().timeIntervalSince1970
                let diffTime = abs(newTimeStamp - goLastTimeStamp)
                print("diffTime: \(diffTime) / skipCount: \(skipCount)")
                
                if diffTime > 1 && skipCount >= 0 {
                    print("GO First")
                    skipCount += 1
                    
                    goFirstTimeStamp = newTimeStamp
                    collectionView.scrollToItem(at: [0, list.count], at: .left, animated: false)
                }
            }
        } else {
            if scrollCount > oneCycleWidth && offsetX - itemSize >= oneCycleWidth * 2 {
//                print("Check GO Last")
                
                let newTimeStamp = Date().timeIntervalSince1970
                let diffTime = abs(newTimeStamp - goFirstTimeStamp)
                print("diffTime: \(diffTime) / skipCount: \(skipCount)")
                
                if diffTime > 1 && skipCount > 0  {
                    print("GO Last")
                    skipCount -= 1
                    
                    goLastTimeStamp = newTimeStamp
                    collectionView.scrollToItem(at: [0, list.count * 2], at: .left, animated: false)
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = dataSource?.itemIdentifier(for: indexPath) {
            print("model: \(model.number)")
        }
    }
}

struct Model: Hashable {
    let identifier = UUID()
    
    let number: Int
}

final class ColorCell: UICollectionViewCell {
    static let identifier = "ColorCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateView(item: Model) {
        label.text = "#\(item.number)"
        self.backgroundColor = .gray
        self.layer.cornerRadius = 30
    }
}
