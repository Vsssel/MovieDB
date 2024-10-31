import UIKit
import SnapKit

// MARK: - MovieDetailView

class MovieDetailView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Properties
    private var movieDetail: MovieDetail
    
    // MARK: - Subviews
    let collectionViewContainer = UIView()
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let movieTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textAlignment = .center
        return title
    }()
    
    private let releaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let ratingFromTen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        super.init(frame: .zero)
        setupView(movieDetail: movieDetail)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods

    private func setupView(movieDetail: MovieDetail) {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        setUpMovieTitle(movieDetail)
        setUpMovieInfo(movieDetail)
        movieOverview(movieDetail)
        movieCast()
    }

    private func setUpMovieTitle(_ movieDetail: MovieDetail) {
        // Call loadImage to fetch the movie image from the URL
        NetworkingManager.shared.loadImage(posterPath: movieDetail.posterPath) { [weak self] image in
            // Set the fetched image to movieImage
            self?.movieImage.image = image
        }
        
        movieTitle.text = movieDetail.belongsToCollection?.name
        
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitle)
        
        movieImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(420)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }


    private func setUpMovieInfo(_ movieDetail: MovieDetail) {
        releaseDate.text = "Release date: \(movieDetail.releaseDate)"
        ratingFromTen.text = "\(movieDetail.voteAverage)/10"
        
        let genreLabels = createGenreLabels(genres: movieDetail.genres)
        let ratingStarViews = createRatingStars(rating: Int(floor((movieDetail.voteAverage / 10) * 5)))
        
        let genreStackView = UIStackView(arrangedSubviews: genreLabels)
        genreStackView.axis = .horizontal
        genreStackView.spacing = 8
        genreStackView.distribution = .fillEqually
        
        let ratingStackView = UIStackView(arrangedSubviews: ratingStarViews)
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        ratingStackView.distribution = .fillEqually
        
        let leftStack = UIStackView(arrangedSubviews: [releaseDate, genreStackView])
        leftStack.axis = .vertical
        leftStack.spacing = 8
        leftStack.distribution = .fill
        
        let rightStack = UIStackView(arrangedSubviews: [ratingStackView, ratingFromTen])
        rightStack.axis = .vertical
        rightStack.spacing = 8
        rightStack.distribution = .fill
        
        let mainStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.distribution = .fillEqually
        
        contentView.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func movieOverview(_ movieDetail: MovieDetail) {
        overviewLabel.text = movieDetail.overview
        let overviewTitle = UILabel()
        overviewTitle.text = "Overview"
        overviewTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        overviewTitle.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [overviewTitle, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(ratingFromTen.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func movieCast() {
        let castTitle = UILabel()
        castTitle.text = "Cast"
        castTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        castTitle.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [castTitle, collectionViewContainer])
        stack.axis = .vertical
        stack.spacing = 10
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(130)
        }
        
        collectionViewContainer.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
    }

    private func createGenreLabels(genres: [Genre]) -> [UILabel] {
        return genres.map { genre in
            let label = UILabel()
            label.text = genre.name
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = .blue
            label.textColor = .white
            return label
        }
    }

    private func createRatingStars(rating: Int) -> [UIImageView] {
        return (0..<5).map { index in
            let starImage = index < rating ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            let starImageView = UIImageView(image: starImage)
            starImageView.tintColor = .systemYellow
            starImageView.contentMode = .scaleAspectFit
            return starImageView
        }
    }
}
