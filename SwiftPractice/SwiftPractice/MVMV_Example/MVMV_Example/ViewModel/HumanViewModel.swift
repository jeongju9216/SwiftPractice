//
//  ViewModel.swift
//  MVMV_Example
//
//  Created by 유정주 on 2022/08/11.
//

import UIKit

final class HumanViewModel {
    
    //전체 데이터
    let humans: [Human] = [
        Human(face: UIImage(named: "face1")!, name: "제니"),
        Human(face: UIImage(named: "face2")!, name: "시리"),
        Human(face: UIImage(named: "face3")!, name: "애플")
    ]
    
    //MARK: - Properties
    let faceImage: Observable<UIImage?> = Observable(nil)
    let name: Observable<String?> = Observable(nil)
    
    private var index: Int = 0
    
    init() {
        self.faceImage.value = humans[index].face
        self.name.value = humans[index].name
    }
    
    func clickedNextButton() {
        print("[ViewModel] Click!!")
        
        index = (index+1 < humans.count) ? index+1 : 0
        print("index가 \(index)로 변경되었습니다.")
        
        print("faceImage value를 변경합니다.")
        self.faceImage.value = humans[index].face
        
        print("name value를 변경합니다.")
        self.name.value = humans[index].name
    }
}
