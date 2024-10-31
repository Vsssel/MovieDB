import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        contentView.addSubview(imageView)
        
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cast: ProductionCompany) {
        imageView.image = UIImage(named: cast.logoPath ?? "")
        nameLabel.text = cast.name
    }
}
