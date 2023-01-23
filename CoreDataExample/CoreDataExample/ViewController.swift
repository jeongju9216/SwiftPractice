//
//  ViewController.swift
//  CoreDataExample
//
//  Created by 유정주 on 2023/01/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        savePhoneData(name: "시리",
                      phoneNumber: "010-0000-0000")
        
        fetchContact()
    }

    func savePhoneData(name: String, phoneNumber: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Phone", in: self.container.viewContext)
        
        guard let entity = entity else {
            return
        }
        
        let phone = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        phone.setValue(name, forKey: "name")
        phone.setValue(phoneNumber, forKey: "phoneNumber")
        phone.setValue(Date(), forKey: "createdAt")
        
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchContact() {
        let date = Date()
        print("current Date: \(date)")
        
        do {
            let contact = try self.container.viewContext.fetch(Phone.fetchRequest()) as! [Phone]
            
            for data in contact {
                let distanceSecond: DateComponents = Calendar.current.dateComponents([.minute, .second], from: data.createdAt!, to: date)
                if let diffMin = distanceSecond.minute,
                        diffMin >= 5 {
                    print("Delete!!")
                    self.container.viewContext.delete(data)
                } else {
                    print("name: \(data.name) / number: \(data.phoneNumber) / createdAt: \(data.createdAt)")
                }
            }
            
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

