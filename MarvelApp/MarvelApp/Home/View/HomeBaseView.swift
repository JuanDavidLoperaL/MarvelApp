//
//  HomeBaseView.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import SnapKit
import DesignSystem
import UIKit

final class HomeBaseView: UIView {
    
    // MARK: - Typealias
    typealias strings = AppText.Home
    
    // MARK: - Private UI Properties
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = strings.title
        label.apply(style: .h1Medium(align: .center, color: .black))
        return label
    }()
    
    private let marvelTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private let loader: LoaderBaseView = LoaderBaseView()
    
    // MARK: - Private Properties
    private var datasourceTable: DatasourceMavelTableView?
    private var delegateTable: DelegateMavelTableView?
    
    // MARK: - Internal Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension HomeBaseView: ViewConfigurationProtocol {
    func setupViewHierarchy() {
        [titleLabel, marvelTableView, loader].forEach { view in
            addSubview(view)
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20.0)
            make.leading.equalTo(self.snp.leading).offset(20.0)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        
        marvelTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottomMargin).offset(-5.0)
        }
        
        loader.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func configureViews() {
        self.apply(background: .mainScreen)
        loader.setLoader(message: strings.downloadMessage)
    }
}

// MARK: - Internal Function
extension HomeBaseView {
    func set(viewModel: HomeViewModel) {
        titleLabel.text = viewModel.title
        datasourceTable = DatasourceMavelTableView(viewModel: viewModel)
        delegateTable = DelegateMavelTableView(viewModel: viewModel)
        marvelTableView.dataSource = datasourceTable
        marvelTableView.delegate = delegateTable
        marvelTableView.reloadData()
    }
    
    func reloadTableView() {
        marvelTableView.reloadData()
    }
    
    func showLoader(with trackValue: CGFloat) {
        loader.showLoader(with: trackValue)
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.alpha = 0.0
    }
    
    func loaderFinished(withError: Bool) {
        if withError {
            loader.finishWithError()
        } else {
            loader.finish()
        }
    }
}
