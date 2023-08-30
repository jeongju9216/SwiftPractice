//
//  PosterCollectionViewCell.swift
//  JICExample
//
//  Created by 유정주 on 2023/08/10.
//

import UIKit
import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
    }
    
    //MARK: - Methods
    func configure(with urlString: String) {
        posterImageView.image = nil
        guard let url = URL(string: urlString) else { return }
        
//        posterImageView.kf.setImage(with: url)
        
        let symbolName = "circle.fill" // SF Symbol의 이름
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24.0) // 포인트 크기 설정
        let symbolImage = UIImage(systemName: symbolName, withConfiguration: symbolConfig)

        posterImageView.jf.setImage(with: url,
                                    placeHolder: symbolImage,
                                    waitPlaceHolderTime: 1,
                                    options: [.downsamplingScale(1.5), .forceRefresh])
    }
    
    func cancelDownloadImage(urlString: String) {
//        posterImageView.kf.cancelDownloadTask()
        posterImageView.jf.cancelDownloadImage()
    }
}
