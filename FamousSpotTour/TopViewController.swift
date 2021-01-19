//
//  TopViewController.swift
//  FamousSpotTour
//
//  Created by Yurie.K on 2021-01-18.
//

import UIKit

// to pass which image tapped
class ImageTapGesture: UITapGestureRecognizer {
    var imageName = String()
    var color = UIColor()
    var note = String()
}

class TopViewController: UIViewController {
    
    var categories: [Category] = [
        Category(imageName: "Circle Old",
                 color: UIColor(hex: "#3EC6FF")!,
                 note: "It provides a calm and relaxing place in Vancouver. The prices are a bit higher, but all places are relaxing spots. There are plenty of facilities and services for families to enjoy."),
        Category(imageName: "Circle Family",
                 color: UIColor(hex: "#4CAF50")!,
                 note: "Although it is a large city, it is surrounded by the sea and mountains and is full of greenery. Vancouver is a city with so much to offer that you will never get bored no matter how many days or years you spend there."),
        Category(imageName: "Circle Young",
                 color: UIColor(hex: "#E91E63")!,
                 note: "Here are some reasonably priced spots that even students can enjoy. You can enjoy the beach in summer and winter sports in winter."),
        Category(imageName: "Circle Student",
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
        navigationItem.rightBarButtonItem = goTourButton
        
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
        NSLayoutConstraint.activate([
            noteLabel.centerXAnchor.constraint(equalTo: noteV.centerXAnchor),
            noteLabel.centerYAnchor.constraint(equalTo: noteV.centerYAnchor),
            noteLabel.widthAnchor.constraint(equalTo: noteV.widthAnchor, constant: -20),
        ])
        
        // default display
        noteV.backgroundColor = categories[0].color
        noteLabel.text = categories[0].note
    }
    
    func generateVStackView() -> VerticalStackView {
        // Images
        var imageViews = [UIImageView]()
        for i in 0..<categories.count {
            imageViews.append(generateImageView(category: categories[i]))
        }
        let vStackView = VerticalStackView(arrangedSubviews: imageViews, spacing: 30, alignment: .fill, distribution: .fillEqually)
        return vStackView
    }
    
    func generateImageView(category: Category) -> UIImageView {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: category.imageName);
        iv.image = image;
        iv.contentMode = .center
        // Tap gesture
        let tap = ImageTapGesture.init(target: self, action: #selector(imageTapped(_:)))
        tap.imageName = category.imageName
        tap.color = category.color
        tap.note = category.note
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }
    
    @objc func imageTapped(_ sender:ImageTapGesture) {
        noteV.backgroundColor = sender.color
        noteLabel.text = sender.note
    }
    
    // move to map
    @objc func goTour() {
        print("move to map")
//        let mapVC = MapViewController()
//        navigationController?.pushViewController(mapVC, animated: true)
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                // RGBA
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 {
                // RGB + Alpha=1.0
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    a = CGFloat(1.0)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
