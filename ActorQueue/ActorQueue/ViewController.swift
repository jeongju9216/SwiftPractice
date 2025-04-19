//
//  ViewController.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import UIKit
import SwiftUI
import SnapKit

final class ViewController: UIViewController {

    private let chatListHostingView: UIHostingController<ChatListView> = .init(rootView: .init())
    private var chatListView: ChatListView { chatListHostingView.rootView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatListHostingView.view)
        chatListHostingView.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

