//
//  ActorViewController.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import UIKit

class ActorViewController: UIViewController {
    
    private var actor: Actor
    
    private lazy var actorInfoView: ActorInfoView = {
        return ActorInfoView(actorInfo: actor)
    }()

    init(actor: Actor) {
        self.actor = actor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupActorDetails()
    }
    
    private func setupActorDetails() {
        title = "Actor"
        view.addSubview(actorInfoView)
        
        actorInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

