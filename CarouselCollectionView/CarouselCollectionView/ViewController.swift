//
//  ViewController.swift
//  CarouselCollectionView
//
//  Created by 유정주 on 2023/02/12.
//

import UIKit

class ViewController: UIViewController {

    private let itemSize: CGFloat = 180
    private let list = (1...10).map { $0 }

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.configureView()
        self.configureCollectionView()
        self.configureDataSource()
        self.configureSnapShot()
        
        collectionView.delegate = self
    }

    private func bindSnapShotApply(section: Section, item: [Model]) {
        DispatchQueue.global().sync {
            guard var snapShot = self.dataSource?.snapshot() else { return }
            
            item.forEach {
                snapShot.appendItems([$0], toSection: section)
            }
            
            self.dataSource?.apply(snapShot, animatingDifferences: true) { [weak self] in
                self?.collectionView.scrollToItem(at: [0, 0],
                                                  at: .centeredHorizontally,
                                                  animated: false)
            }
        }
    }

    private func configureSnapShot() {
        var snapShot = Snapshot()
        
        snapShot.appendSections([.Main])
        
        self.dataSource?.apply(snapShot, animatingDifferences: true)
        
        var listItem: [Model] = []
        for item in list {
            listItem.append(Model(number: item))
        }
        for i in 0..<(min(list.count, 3)) {
            listItem.append(Model(number: i))
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
        
        NSLayoutConstraint.activate([
            self.collectionView.heightAnchor.constraint(equalToConstant: 200),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
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
                
                let index = Int(ceil(offset.x / env.container.contentSize.width))
                
                print("In Visible: \(offset.x)")
                if offset.x >= self.itemSize * CGFloat(self.list.count) {
                    self.collectionView.scrollToItem(at: [0, 0], at: .centeredHorizontally, animated: false)
                }
            }
            
            return section
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
