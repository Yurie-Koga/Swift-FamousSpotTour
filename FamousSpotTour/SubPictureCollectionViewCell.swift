//
//  SubPictureCollectionViewCell.swift
//  FamousSpotTour
//
//  Created by Yurie.K on 2021-01-25.
//

import UIKit

class SubPictureCollectionViewCell: UICollectionViewCell {

    let pictureIV: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(pictureIV)
        NSLayoutConstraint.activate([
            pictureIV.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            pictureIV.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
      fatalError()
    }
}
