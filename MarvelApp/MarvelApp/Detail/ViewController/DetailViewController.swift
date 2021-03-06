//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func setValueInLoader(track: CGFloat)
    func informationLoadedWithSucess()
    func errorLoadingInformation()
}

final class DetailViewController: UIViewController {
    
    typealias screenText = AppText.Detail
    
    // MARK: - Private UI Properties
    private let baseView: DetailBaseView = DetailBaseView()
    
    // MARK: - Private Properties
    private let coordinator: AppCoordinator
    private let viewModel: DetailViewModel
    
    // MARK: - Internal Init
    init(coordinator: AppCoordinator, viewModel: DetailViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenText.title
        viewModel.delegate = self
        getInformation()
    }
}

// MARK: - Private Function
private extension DetailViewController {
    func getInformation() {
        viewModel.startPercentLoader()
        viewModel.getCharacterDetail { [weak self] result in
            if !result {
                self?.showAlertError()
            } else {
                self?.baseView.set(viewModel: self?.viewModel ?? DetailViewModel(characterId: 0))
            }
        }
    }
    
    func showAlertError() {
        let alert: UIAlertController = UIAlertController(title: screenText.alertErrorTitle,
                                                         message: "Main Problmen: \(viewModel.httpError ?? .genericError)\n\n\(screenText.alertErrorMessage)",
                                                         preferredStyle: .alert)
        let tryAgainAction: UIAlertAction = UIAlertAction(title: screenText.alertTryAgainAction, style: .default) { _ in
            self.getInformation()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: screenText.alertCancelButton, style: .destructive) { _ in
            self.coordinator.navigateToPreviousScreen()
        }
        [tryAgainAction, cancelAction].forEach { action in
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - WelcomeViewController Protocol Implementation
extension DetailViewController: DetailViewControllerDelegate {
    func setValueInLoader(track: CGFloat) {
        baseView.showLoader(with: track)
    }
    
    func informationLoadedWithSucess() {
        baseView.loaderFinished(withError: false)
    }
    
    func errorLoadingInformation() {
        baseView.loaderFinished(withError: true)
    }
}
