//
//  ViewController.swift
//  MVMV_Example
//
//  Created by 유정주 on 2022/08/11.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    //MARK: - Properties
    private let humanViewModel: HumanViewModel = HumanViewModel()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    //MARK: - Methods
    private func bind() {
        humanViewModel.faceImage.bind { faceImage in
            self.faceImageView.image = faceImage
            print("[View] faceImage 이미지 변경 완료")
        }
        
        humanViewModel.name.bind { name in
            self.nameLabel.text = name
            print("[View] nameLabel 텍스트 변경 완료")
        }
    }

    //MARK: - Actions
    @IBAction func clickedNextButton(_ sender: UIButton) {
        print("[View] Click!!")
        humanViewModel.clickedNextButton()
    }
}

