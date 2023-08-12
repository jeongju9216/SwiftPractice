//
//  ViewController.swift
//  JICExample
//
//  Created by 유정주 on 2023/08/10.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        String(describing: self)
    }
}

class ViewController: UIViewController {
    enum Sections: Int {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Sections, String>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Sections, String>
    
    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCollectionViewLayout())
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        return collectionView
    }()

    //MARK: - Properties
    private let testItem: [String] = Array(repeating: "https://picsum.photos/500", count: 100)

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
                
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    //MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150),
                                                  heightDimension: .absolute(220))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
            let sectionInset = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
            section.contentInsets = sectionInset
            
            return section
        }
        
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PosterCollectionViewCell else { return }
        
        cell.cancelDownloadImage()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
            return .init()
        }
        
        cell.configure(with: testItem[indexPath.row])
        
        return cell
    }
}
