//
//  ViewController.swift
//  PreviewExaple
//
//  Created by 유정주 on 11/1/23.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func update(text: String) {
        self.label.text = text
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
    return vc
}
