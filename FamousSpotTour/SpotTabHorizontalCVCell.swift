//
//  SpotTabHorizontalCVCell.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-22.
//

import UIKit

class SpotTabHorizontalCVCell: UICollectionViewCell {
    
    let showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.matchSize()
        imageView.frame = .init(x: 0, y: 0, width: 10, height: 10)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(showImageView)

        showImageView.centerXYin(self)
        showImageView.constraintWidth(equalToConstant: self.bounds.width, heightEqualToConstant: self.bounds.width
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with location: Location) {
        //      emojiSymbolLabel.text = emoji.symbol
        //      emojiNameLabel.text = emoji.name
        //      emojiDescriptionLabel.text = emoji.description
    }
    
    
}
