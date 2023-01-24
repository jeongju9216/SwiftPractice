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
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        self.viewContext = container.viewContext
                
        setupSearchBar()
        
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    //MARK: - Actions
    @IBAction func clickedButton(_ sender: UIButton) {
        fetchContact()
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
                }
            }
            .store(in: &cancellables)
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

    func fetchContact() {
        do {
            let fetchRequest = Keyword.fetchRequest()
            
            let contact = try self.viewContext.fetch(fetchRequest)
            
            for data in contact {
                print("[Fetch] keyword: \(data.keyword) / createdAt: \(data.createdAt)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    //텍스트 입력을 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //검색 버튼을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()

        guard let text = searchBar.text else {
            return
        }
        
        print("Search: \(text)")
        
        saveKeyword(keyword: text)
    }
    
    //취소 버튼을 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        self.searchController.searchBar.text = ""
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
