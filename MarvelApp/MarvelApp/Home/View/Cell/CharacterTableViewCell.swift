//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import DesignSystem
import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - Private UI Properties
    private let characterImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    private let stackViewVertical: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h2Regular(align: .left, color: .body))
        label.numberOfLines = 0
        return label
    }()
    
    private let comicsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h2Regular(align: .left, color: .body))
        return label
    }()
    
    private let seriesLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h2Regular(align: .left, color: .body))
        return label
    }()
    
    // MARK: - Static Properties
    static let cellIdentifier: String = "charactersCell"
    
    // MARK: - Internal Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharacterTableViewCell: ViewConfigurationProtocol {
    func setupViewHierarchy() {
        [characterImage, stackViewVertical].forEach { view in
            contentView.addSubview(view)
        }
        [seriesLabel, comicsLabel, descriptionLabel].forEach { view in
            stackViewVertical.addArrangedSubview(view)
        }
    }
    
    func setupConstraints() {
        characterImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10.0)
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.height.equalTo(70.0)
            make.width.equalTo(70.0)
        }
        
        stackViewVertical.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(10.0)
            make.leading.equalTo(contentView.snp.leading).offset(20.0)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20.0)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20.0)
        }
        
        seriesLabel.snp.makeConstraints { make in
            make.height.equalTo(17.0)
        }
        
        seriesLabel.snp.makeConstraints { make in
            make.height.equalTo(17.0)
        }
    }
    
    func configureViews() {
        contentView.apply(background: .mainScreen)
    }
}

// MARK: - Internal Function
extension CharacterTableViewCell {
    func set(viewModel: HomeViewModel) {
        characterImage.load(url: viewModel.information.icon)
        seriesLabel.text = viewModel.information.series
        comicsLabel.text = viewModel.information.comics
        descriptionLabel.text = viewModel.information.description
    }
}
