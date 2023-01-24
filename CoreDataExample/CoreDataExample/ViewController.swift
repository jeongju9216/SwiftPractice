//
//  ViewController.swift
//  CoreDataExample
//
//  Created by 유정주 on 2023/01/23.
//

import UIKit
import CoreData
import Combine

final class ViewController: UIViewController {

    var container: NSPersistentContainer!
    var viewContext: NSManagedObjectContext!
    
    private let searchController: UISearchController = UISearchController()
    
    private var cancellables: Set<AnyCancellable> = []
            
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section: CaseIterable {
        case main
    }
    
    var keywords: [String] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        self.viewContext = container.viewContext
                
        setupSearchBar()
        
        removeAllCoreData()
        
        self.keywords = fetchContact()
        
        self.collectionView.collectionViewLayout = createLayout()
        setupDataSource()
        performQuery()
        
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    //MARK: - Methods
    func bind() {
        searchController.searchBar.searchTextField
            .debounceSearchPublisher
            .sink { [weak self] receivedValue in
                guard let self = self else {
                    return
                }
                
                print("receivedValue: \(receivedValue)")
                if !receivedValue.isEmpty {
                    self.update(keyword: receivedValue)
                    
                    self.keywords = self.fetchContact()
                    
                    self.performQuery()
                }
            }
            .store(in: &cancellables)
    }
    
    func setupDataSource() {
        self.collectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.identifier)
        self.dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView) { [weak self] (collectionView, indexPath, dj) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.identifier,
                                                                for: indexPath) as? KeywordCollectionViewCell,
                let self = self else {
                preconditionFailure()
            }
            
            cell.configure(systemName: "iphone", keyword: self.keywords[indexPath.item])
            
            return cell
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let columns = 1
            let spacing = CGFloat(10)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(50))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        
        return layout
    }
    
    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(keywords)
        
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func setupSearchBar() {
        navigationItem.searchController = self.searchController

        searchController.searchBar.placeholder = "검색하세요."
        searchController.searchBar.delegate = self
    }
    
    func saveKeyword(keyword: String) {
        print("[Save] \(keyword)")
        
        let entity = NSEntityDescription.entity(forEntityName: "Keyword", in: self.viewContext)
        
        guard let entity = entity else {
            return
        }
        
        let object = Keyword(entity: entity, insertInto: self.viewContext)
        object.keyword = keyword
        object.createdAt = Date()
        
        do {
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(keyword: String) {
        let fetchRequest = Keyword.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "keyword == %@", keyword)
        
        do {
            let contact = try self.viewContext.fetch(fetchRequest)
            
            if contact.isEmpty {
                saveKeyword(keyword: keyword)
            } else {
                print("[Update] \(keyword)")
                
                let updatedObject: Keyword = contact[0]
                
                updatedObject.setValue(Date(), forKey: "createdAt")
                
                try self.viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchContact() -> [String] {
        var keywords: [String] = []
        do {
            let fetchRequest = Keyword.fetchRequest()
            
            let contact = try self.viewContext.fetch(fetchRequest)
            
            for data in contact {
                print("[Fetch] keyword: \(data.keyword) / createdAt: \(data.createdAt)")
                keywords.append(data.keyword ?? "")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return keywords
    }
    
    func removeAllCoreData() {
        do {
            let fetchRequest = Keyword.fetchRequest()
            
            let contact = try self.viewContext.fetch(fetchRequest)
            
            for data in contact {
                print("[Fetch] keyword: \(data.keyword) / createdAt: \(data.createdAt)")
                self.viewContext.delete(data)
            }
            
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    //텍스트 입력을 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.setShowsCancelButton(true, animated: true)
        
        UIView.animate(withDuration: 0.05, delay: 0.3) {
            self.collectionView.alpha = 1
        }
    }
    
    //검색 버튼을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()

        guard let text = searchBar.text else {
            return
        }
        
        print("Search: \(text)")
        
        update(keyword: text)
    }
    
    //취소 버튼을 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        self.searchController.searchBar.text = ""
        
        self.collectionView.alpha = 0
    }
    
    //키보드 숨기기
    private func dismissKeyboard() {
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension UISearchTextField {
    var debounceSearchPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UISearchTextField.textDidChangeNotification,
            object: self)
            .compactMap { $0.object as? UISearchTextField }
            .map { $0.text ?? "" }
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

class KeywordCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "KeywordCollectionViewCell"
    
    var iconImageView: UIImageView!
    var keywordLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        
        iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        keywordLabel = UILabel()
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        keywordLabel.textAlignment = .center
        
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(keywordLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            
            keywordLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            keywordLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
    func configure(systemName: String, keyword: String) {
        self.iconImageView.image = UIImage(systemName: systemName)
        self.keywordLabel.text = keyword
    }
}
