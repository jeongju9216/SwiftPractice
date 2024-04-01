//
//  ViewController.swift
//  HorizontalCollectionView
//
//  Created by 유정주 on 4/1/24.
//

import UIKit
import Kingfisher
import SnapKit

final class Cell: UICollectionViewCell {
    
    enum Metric {
        
        static let length = 240.0
        static let short = 188.0
        static let ratio = 1.27
    }
    
    func update(isSelected: Bool) {
        if isSelected {
            containerView.layer.borderWidth = 4
            containerView.layer.borderColor = UIColor.red.cgColor
        } else {
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    let containerView = UIView()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAttributes() {
        containerView.backgroundColor = .green
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 20
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setUpSubviews() {
        containerView.addSubview(imageView)
        addSubview(containerView)
    }
    
    private func setUpConstraints() {
        let defaultSize = CGSize(width: Metric.length, height: Metric.length)
        containerView.snp.makeConstraints {
            $0.size.equalTo(defaultSize)
            $0.centerY.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(imageURLString: String) {
        imageView.kf.setImage(with: URL(string: imageURLString)) { [weak self] result in
            guard let self else { return }
            guard case .success(let imageResult) = result else {
                return
            }
            
            let size = imageResult.image.size
            let ratio = max(size.width, size.height) / min(size.width, size.height)
            print("size: \(size) / ratio: \(ratio)")
            
            imageView.snp.remakeConstraints {
                $0.size.equalTo(size)
                $0.center.equalToSuperview()
            }
            if ratio > Metric.ratio && size.width > size.height {
                // 가로 직사각형
                updateContainerView(size: CGSize(width: Metric.length, height: Metric.short))
            } else if ratio > Metric.ratio && size.height > size.width {
                // 세로 직사각형
                updateContainerView(size: CGSize(width: Metric.short, height: Metric.length))
            } else {
                updateContainerView(size: CGSize(width: Metric.length, height: Metric.length))
            }
        }
    }
    
    func updateContainerView(size: CGSize) {
        containerView.snp.remakeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
        }
    }
}

final class ViewController: UIViewController {
    
    
    // MARK: - UI
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    private var nextButton = UIButton(), prevButton = UIButton()
    
    // MARK: - Attributes
    
    private let images: [String] = [
        "https://fakeimg.pl/240x240",
        "https://fakeimg.pl/240x188",
        "https://fakeimg.pl/188x240",
        "https://fakeimg.pl/240x220"
    ]
    private var currentIndex = 0
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
        setupCollectionView()
    }
    
    
    // MARK: - Setup
    
    private func setUpAttributes() {
        collectionView.backgroundColor = .gray
        
        prevButton.setTitle("prev", for: .normal)
        prevButton.backgroundColor = .red
        prevButton.addTarget(self, action: #selector(prevButtonDidTap), for: .touchUpInside)
        
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = .red
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
        view.addSubview(prevButton)
        view.addSubview(nextButton)
    }
    
    private func setUpConstraints() {
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
            $0.center.equalToSuperview()
        }
        prevButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(240),
            heightDimension: .absolute(240)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        setupCollectionViewCarousel(to: section)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setupCollectionViewCarousel(to section: NSCollectionLayoutSection) {
        section.visibleItemsInvalidationHandler = { visibleItems, offset, environment in
            let containerWidth = environment.container.contentSize.width
            
            visibleItems.forEach { [weak self] item in
                guard let self else { return }
                
                let itemCenterRelativeToOffset = item.frame.midX - offset.x
                
                // 셀이 컬렉션 뷰의 중앙에서 얼마나 떨어져 있는지
                let distanceFromCenter = abs(itemCenterRelativeToOffset - containerWidth / 2.0)
                
                // 셀이 커지고 작아질 때의 최대 스케일, 최소 스케일
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                
                if let cell = collectionView.cellForItem(at: item.indexPath) as? Cell {
                    cell.update(isSelected: item.indexPath.row == currentIndex)
                }
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
    
    @objc
    func prevButtonDidTap(_ sender: UIButton) {
        currentIndex -= 1
        currentIndex = max(currentIndex, 0)
        collectionView.selectItem(at: IndexPath(row: currentIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @objc
    func nextButtonDidTap(_ sender: UIButton) {
        currentIndex += 1
        currentIndex = min(currentIndex, images.count - 1)
        collectionView.selectItem(at: IndexPath(row: currentIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}


extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(imageURLString: images[indexPath.row])
        cell.update(isSelected: indexPath.row == currentIndex)
        return cell
    }
}
