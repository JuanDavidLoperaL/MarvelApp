//
//  AppCoordinator.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    
    // MARK: - Internal Init
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Functions
    func start() -> UINavigationController {
        let viewController: HomeViewController = HomeViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: true)
        return navigationController
    }
    
    func navigateToDetail(with id: Int) {
        let viewModel: DetailViewModel = DetailViewModel(characterId: id)
        let viewController: DetailViewController = DetailViewController(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToPreviousScreen() {
        navigationController.popViewController(animated: true)
    }
}

