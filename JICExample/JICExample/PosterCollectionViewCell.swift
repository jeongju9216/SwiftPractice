//
//  PosterCollectionViewCell.swift
//  JICExample
//
//  Created by 유정주 on 2023/08/10.
//

import UIKit
import Kingfisher
import Jeongfisher

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
        posterImageView.jf.setImage(with: url)
    }
    
    func cancelDownloadImage(urlString: String) {
//        posterImageView.kf.cancelDownloadTask()
        posterImageView.jf.cancelDownloadImage()
    }
}
