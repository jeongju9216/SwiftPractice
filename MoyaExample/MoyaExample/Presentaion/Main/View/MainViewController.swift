//
//  ViewController.swift
//  MoyaExample
//
//  Created by 유정주 on 2023/01/28.
//

import UIKit
import Combine

final class MainViewController: UIViewController {

    //MARK: - Views
    private let searchController: UISearchController = .init()
    @IBOutlet weak var containerView: UIView!
    private var containerViewControllers: [UIViewController] = []
    
    //MARK: - Properties
    var viewModel: MainViewModel!
    var currentContainerMode: ContainerMode = .search
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContainerVC(.home)
        setupSearchController()
        
        bind()
    }
    
    private func bind() {
        viewModel.$apps
            .receive(on: RunLoop.main)
            .sink { [weak self] apps in
                guard let self = self else { return }
                
                var result: String = ""
                for app in apps {
                    result += "\(app.name ?? "")\n"
                }
                print("==== result ====")
                print("\(result)")
                
                //현재 최상단의 VC가 SearchVC라면 Label 업데이트
                if let currentVC = self.containerViewControllers.last,
                   let searchVC = currentVC as? SearchViewController {
                    searchVC.updateLabel(result)
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Setup
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "검색어를 입력하세요."
        
        navigationItem.searchController = searchController
    }
    
    //MARK: - Method
    private func updateCurrentContainerMode(_ mode: ContainerMode) {
        currentContainerMode = mode
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        addContainerVC(.search)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text, !text.isEmpty {
            print("text: \(text)")
            viewModel.action(.search(text))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        updateCurrentContainerMode(.home)
        popContainerVC()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.action(.updateText(searchText))
    }
}

//MARK: - Container Method
extension MainViewController {
    private func addContainerVC(_ containerMode: ContainerMode) {
        print("current: \(currentContainerMode) / new: \(containerMode)")
        guard currentContainerMode != containerMode else {
            return
        }
        
        var viewController: UIViewController?
        switch containerMode {
        case .home:
            viewController = HomeViewController.instantiate
        case .search:
            viewController = SearchViewController.instantiate
        default: break
        }
        
        if let vc = viewController {
            updateCurrentContainerMode(containerMode)
            containerViewControllers.append(vc)
            
            containerView.addSubview(vc.view)
            self.addChild(vc)
            
            applyConstraintWithContainer(vc)
                        
            vc.didMove(toParent: self)
        }
    }
    
    private func popContainerVC() {
        //홈 VC는 pop하면 안 됨
        guard containerViewControllers.count > 1 else {
            return
        }
        
        if let last = containerViewControllers.popLast() {
            last.removeViewController()
        }
    }
    
    private func applyConstraintWithContainer(_ vc: UIViewController) {
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vc.view.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            vc.view.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            vc.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            vc.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
