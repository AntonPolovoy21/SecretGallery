//
//  GalleryCell.swift
//  SecretGallery
//
//  Created by Admin on 20.10.23.
//

import Foundation
import UIKit
import SnapKit

class GalleryCell: UICollectionViewCell {
    
    static let identifier = "GalleryCell"
    
    private let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
    }
    
    public func configure(withImage image: UIImage){
        imageView.image = image
    }
}
