//
//  ViewController.swift
//  CoreDataExample
//
//  Created by 유정주 on 2023/01/23.
//

import UIKit
import CoreData

final class ViewController: UIViewController {

    var container: NSPersistentContainer!
    var viewContext: NSManagedObjectContext!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        self.viewContext = container.viewContext
        
        setupSearchBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    //MARK: - Actions
    @IBAction func clickedButton(_ sender: UIButton) {
        fetchContact()
    }
    
    //MARK: - Methods
    func setupSearchBar() {
        searchBar.placeholder = "검색하세요."
        searchBar.delegate = self
    }
    
    func saveKeyword(keyword: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Keyword", in: self.viewContext)
        
        guard let entity = entity else {
            return
        }
        
        let object = NSManagedObject(entity: entity, insertInto: self.viewContext)
        object.setValue(keyword, forKey: "keyword")
        object.setValue(Date(), forKey: "createdAt")
        
        do {
            try self.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchContact() {
        let date = Date()
        print("current Date: \(date)")
        
        do {
            let contact = try self.container.viewContext.fetch(Keyword.fetchRequest()) as! [Keyword]
            
            for data in contact {
                let distanceSecond: DateComponents = Calendar.current.dateComponents([.minute, .second], from: data.createdAt!, to: date)
                if let diffMin = distanceSecond.minute,
                        diffMin >= 5 {
                    print("Delete!!")
                    self.container.viewContext.delete(data)
                } else {
                    print("keyword: \(data.keyword) / createdAt: \(data.createdAt)")
                }
            }
            
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    //텍스트 입력을 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //텍스트가 변경될 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        
        print("Input: \(text)")
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
        
        self.searchBar.text = ""
    }
    
    //키보드 숨기기
    private func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
}
