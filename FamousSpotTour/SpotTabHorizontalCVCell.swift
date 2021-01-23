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
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(showImageView)
        
//        showImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        showImageView.centerXYin(self)
        showImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        showImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        
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
