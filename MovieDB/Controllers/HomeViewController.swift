//
//  ViewController.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private let movieCard: HomeView = {
        let image = UIImage(named: "movieImage")
        let movieTitle = "Uncharted"
        return HomeView(image: image, title: movieTitle)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        view.backgroundColor = .white
        title = "MovieDB"
        
        view.addSubview(movieCard)
        movieCard.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16);
            make.height.equalTo(500)
        }
    }
 }

