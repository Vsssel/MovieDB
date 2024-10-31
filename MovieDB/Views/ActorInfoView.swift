//
//  ActorInfoView.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import UIKit
import SnapKit

class ActorInfoView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var actorInfo: Actor

    private let actorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let actorName: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textAlignment = .center
        return title
    }()
    
    private let actorBornDate: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        title.textAlignment = .center
        return title
    }()
    
    private let actorBornPlace: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        title.textAlignment = .center
        return title
    }()
    
    private let bornDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init
    init(actorInfo: Actor) {
        self.actorInfo = actorInfo
        super.init(frame: .zero)
        setupView(actorInfo)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(_ actorInfo: Actor) {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        setUpActorInfo(actorInfo)
        setupActorBio(actorInfo)
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(bioLabel.snp.bottom).offset(20)
        }
    }

    private func setUpActorInfo(_ actorInfo: Actor) {
        actorImage.image = UIImage(named: actorInfo.image)
        actorName.text = actorInfo.name
        actorBornDate.text = actorInfo.bornDate
        actorBornPlace.text = actorInfo.bornPlace
        
        let stack = UIStackView(arrangedSubviews: [actorImage, actorName, actorBornDate, actorBornPlace])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        
        contentView.addSubview(stack)
        
        actorImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(420)
        }
        
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
    }

    private func setupActorBio(_ actorInfo: Actor) {
        bioLabel.text = actorInfo.bio
        let bioTitle = UILabel()
        bioTitle.text = "Bio"
        bioTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        bioTitle.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [bioTitle, bioLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(actorBornPlace.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
