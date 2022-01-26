//
//  DetailBaseView.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import DesignSystem
import UIKit

final class DetailBaseView: UIView {
    
    // MARK: - Private UI Properties
    private let characterNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h1Medium(align: .center, color: .black))
        return label
    }()
    
    private let characterImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h2Regular(align: .left, color: .body))
        label.numberOfLines = 0
        return label
    }()
    
    private let eventLabel: UILabel = {
        let label: UILabel = UILabel()
        label.apply(style: .h2Regular(align: .left, color: .body))
        label.numberOfLines = 0
        return label
    }()
    
    private let loader: LoaderBaseView = LoaderBaseView()
    
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

extension DetailBaseView: ViewConfigurationProtocol {
    func setupViewHierarchy() {
        [characterNameLabel, characterImage, eventLabel, descriptionLabel, loader].forEach { view in
            addSubview(view)
        }
    }
    
    func setupConstraints() {
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(10.0)
            make.leading.equalTo(self.snp.leading).offset(20.0)
            make.trailing.equalTo(self.snp.trailing).offset(-20.0)
            make.height.equalTo(26.0)
        }
        
        characterImage.snp.makeConstraints { make in
            make.top.equalTo(characterNameLabel.snp.bottom).offset(20.0)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(90.0)
            make.width.equalTo(90.0)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(10.0)
            make.leading.equalTo(self.snp.leading).offset(20.0)
            make.trailing.equalTo(self.snp.trailing).offset(-20.0)
            make.height.equalTo(17.0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(eventLabel.snp.bottom).offset(10.0)
            make.leading.equalTo(self.snp.leading).offset(20.0)
            make.trailing.equalTo(self.snp.trailing).offset(-20.0)
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
    }
}


// MARK: - Internal Function
extension DetailBaseView {
    func set(viewModel: DetailViewModel) {
        characterNameLabel.text = viewModel.information.name
        characterImage.load(url: viewModel.information.image)
        descriptionLabel.text = viewModel.information.description
        eventLabel.text = viewModel.information.event
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
