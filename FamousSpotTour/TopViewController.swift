//
//  TopViewController.swift
//  FamousSpotTour
//
//  Created by Yurie.K on 2021-01-18.
//

import UIKit
import SnapKit

struct Tag {
    var id = Int()
    var imageName = String()
    var color = UIColor()
    var note = String()
}

// to pass which image tapped
class ImageTapGesture: UITapGestureRecognizer {
    var id = Int()
    var imageName = String()
    var color = UIColor()
    var note = String()
}

class TopViewController: UIViewController {
    
    var selectedTag = Int()
    var tags: [Tag] = [
        Tag(id: 1,
            imageName: "Circle Old",
            color: UIColor(hex: "#3EC6FF")!,
            note: "It provides a calm and relaxing place in Vancouver. The prices are a bit higher, but all places are relaxing spots. There are plenty of facilities and services for families to enjoy."),
        Tag(id: 2,
            imageName: "Circle Family",
            color: UIColor(hex: "#4CAF50")!,
            note: "Although it is a large city, it is surrounded by the sea and mountains and is full of greenery. Vancouver is a city with so much to offer that you will never get bored no matter how many days or years you spend there."),
        Tag(id: 3,
            imageName: "Circle Young",
            color: UIColor(hex: "#E91E63")!,
            note: "Here are some reasonably priced spots that even students can enjoy. You can enjoy the beach in summer and winter sports in winter."),
        Tag(id: 4,
            imageName: "Circle Student",
            color: UIColor(hex: "#E040FB")!,
            note: "Although it is a large city, it is surrounded by the sea and mountains and is full of greenery. Here are some exciting spots that you may not have known existed."),
    ]
    
    let noteV = UIView()
    let noteLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide tab bar
        tabBarController?.tabBar.isHidden = true
        // hide back button of nav bar
        navigationItem.leftBarButtonItem = nil
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        view.backgroundColor = .white

        // nav bar
        navigationController?.navigationBar.barTintColor = .white
        title = "Famous Spot Tour"
        let goTourButton = UIBarButtonItem(title: "GoTour!", style: .plain, target: self, action: #selector(goTour))
        self.navigationItem.rightBarButtonItem = goTourButton
        
        // Category
        let imageVSV = generateVStackView()
        noteV.backgroundColor = .systemTeal
        let categoryHSV = HorizontalStackView(arrangedSubviews: [
            imageVSV, noteV,
        ], spacing: 10, alignment: .center, distribution: .fillProportionally)
        view.addSubview(categoryHSV)
        categoryHSV.matchParent(padding: .init(top: 30, left: 16, bottom: 0, right: 0))
        
        noteV.matchParent(padding: .init(top: 0, left: 100, bottom: 0, right: 0))
        noteV.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(noteV.snp.centerX)
            make.centerY.equalTo(noteV.snp.centerY)
            make.width.equalTo(noteV.snp.width).offset(-20)
        }
        
        // default display
        selectedTag = 0
        noteV.backgroundColor = tags[0].color
        noteLabel.text = tags[0].note
    }
    
    func generateVStackView() -> VerticalStackView {
        // Images
        var imageViews = [UIImageView]()
        for i in 0..<tags.count {
            imageViews.append(generateImageView(category: tags[i], categoryIndex: i))
        }
        let vStackView = VerticalStackView(arrangedSubviews: imageViews, spacing: 30, alignment: .fill, distribution: .fillEqually)
        return vStackView
    }
    
    func generateImageView(category: Tag, categoryIndex: Int) -> UIImageView {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: category.imageName);
        iv.image = image;
        iv.contentMode = .center
        // Tap gesture
        let tap = ImageTapGesture.init(target: self, action: #selector(imageTapped(_:)))
        tap.id = categoryIndex
        tap.imageName = category.imageName
        tap.color = category.color
        tap.note = category.note
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }
    
    @objc func imageTapped(_ sender:ImageTapGesture) {
        selectedTag = sender.id
        noteV.backgroundColor = sender.color
        noteLabel.text = sender.note
    }
    
    // move to map
    @objc func goTour() {
        // hide top page's nav bar
        navigationController?.navigationBar.isHidden = true
        
        let mainTBC = MainTabBarController()
        mainTBC.map.setupLocation(selectedTag)
        navigationController?.pushViewController(mainTBC, animated: true)
    }
}

