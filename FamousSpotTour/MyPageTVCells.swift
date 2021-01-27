//
//  MyPageTVCells.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-25.
//

import UIKit

class PictureTVC: UITableViewCell {

    let container = UIView()
    
    let profile: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(container)
        addSubview(profile)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelTVC: UITableViewCell {
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ProgressTVC: UITableViewCell {

    var circleLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    
    var progressCircleView = UIView()
    
    var stackH = UIStackView()
    
    var stackV = UIStackView()
    
    
    
    let todo: UILabel = {
        let label = UILabel()
        label.text = "456"
        label.textColor = UIColor(hex: "#3EC6FF")
        label.font = .boldSystemFont(ofSize: 31)
        return label
    }()
    
    let slash: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = UIColor(hex: "#3EC6FF")
        label.font = .boldSystemFont(ofSize: 31)
        return label
    }()
    
    let did: UILabel = {
        let label = UILabel()
        label.text = "123"
        label.textColor = UIColor(hex: "#3EC6FF")
        label.font = .boldSystemFont(ofSize: 31)
        return label
    }()
    
    let percent: UILabel = {
        let label = UILabel()
        label.text = "70% achived"
        label.textColor = UIColor(hex: "#3EC6FF")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackH = HorizontalStackView.init(arrangedSubviews: [did,slash,todo], spacing: 5, alignment: .center)
        
        stackV = VerticalStackView.init(arrangedSubviews: [stackH,percent], spacing: 5, alignment: .center)
        
        
        addSubview(stackV)
        
        
        
        addSubview(progressCircleView)
        
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        createCircularPath()
    }
    
    func createCircularPath() {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10.0
        circleLayer.strokeColor = UIColor(hex: "#a9e1f9")?.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0.7
        progressLayer.strokeColor = UIColor(hex: "#3EC6FF")?.cgColor
        progressCircleView.layer.addSublayer(circleLayer)
        progressCircleView.layer.addSublayer(progressLayer)
    }
}

class SwitchTVC: UITableViewCell {

    
}
