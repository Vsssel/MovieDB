import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(420)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(2)
        }
    }
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
        NetworkingManager.shared.loadImage(posterPath: movie.posterPath) { [weak self] image in
            self?.movieImageView.image = image
        }
    }
}
