//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Assel Artykbay on 31.10.2024.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private var movieDetail: MovieDetail
    private var collectionView: UICollectionView!
    private var casts: [Cast] = []
    
    private lazy var movieDetailView: MovieDetailView = {
        return MovieDetailView(movieDetail: movieDetail)
    }()

    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        super.init(nibName: nil, bundle: nil)
        NetworkingManager.shared.getMovieDetailsCast(id: movieDetail.id){ casts in
            self.casts = casts
            self.collectionView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupCollectionView()
    }
    
    private func setupViews() {
        title = "Movie"
        view.addSubview(movieDetailView)
        movieDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 100)
        layout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCell")
        
        movieDetailView.collectionViewContainer.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCollectionViewCell
        let cast = casts[indexPath.row]
        cell.configure(with: cast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedActor = casts[indexPath.item]
        print(selectedActor)
        let actorViewController = ActorViewController(id: selectedActor.id!)
        navigationController?.pushViewController(actorViewController, animated: true)
    }
}

