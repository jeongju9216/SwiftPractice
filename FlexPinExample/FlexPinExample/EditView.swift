//
//  EditView.swift
//  FlexPinExample
//
//  Created by 유정주 on 6/4/24.
//

import UIKit
import FlexLayout
import PinLayout
import Then

final class EditView: UIView {
    
    // MARK: - UI
    
    private let flexBox = UIView()
    private let backButton = UIView().then {
        $0.backgroundColor = .black
    }
    private let previewView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .gray
        setUpSubviews()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flexBox.pin.all(pin.safeArea)
        flexBox.flex.layout()
        
        let minSize = min(frame.width, frame.height - 132)
        previewView.pin
            .aspectRatio(1)
            .maxHeight(minSize)
            .verticallyBetween(backButton, and: captureButton).hCenter()
            .align(.center)
    }
    
    // MARK: - Setup
    
    private func setUpSubviews() {
        addSubview(flexBox)
    }
    
    private func setUp() {
        flexBox.flex.direction(.column).define { flex in
            flex.addItem(backButton).size(Size.button)
            
            flex.addItem(previewView).grow(1)
            
            flex.addItem().alignItems(.center).justifyContent(.spaceBetween).direction(.row).define { flex in
                flex.addItem(albumButton).size(Size.button)
                flex.addItem(captureButton).size(Size.capture)
                flex.addItem(switchingButton).size(Size.button)
            }
        }
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
    EditView()
}

// MARK: - Constant

private extension EditView {
    
    enum Size {
        
        static let previewMaxWidth = 600.0
        static let capture = CGSize(width: 88, height: 88)
        static let button = CGSize(width: 44, height: 44)
    }
}
