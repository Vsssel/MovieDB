//
//  HomeView.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import UIKit
import SnapKit

class HomeView: UIView {

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        setupView()
        movieImageView.image = image
        movieTitleLabel.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)

        
        movieImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.height.equalTo(420)
            make.width.equalTo(300)
        }

        movieTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
        }

    }
}

