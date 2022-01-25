//
//  DatasourceMavelTableView.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation
import UIKit

final class DatasourceMavelTableView: NSObject, UITableViewDataSource {
    
    // MARK: - Private Properties
    private let viewModel: HomeViewModel
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Datasource Protocol Implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        viewModel.currentCell = indexPath.row
        cell.set(viewModel: viewModel)
        return cell
    }
}
