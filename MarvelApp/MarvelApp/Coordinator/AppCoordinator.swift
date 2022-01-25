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
}

