//
//  MyPageTVCells.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-25.
//

import UIKit
import RealmSwift

class PictureTVC: UITableViewCell {
    
    let container = UIView()
    
    let profile: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    let changePictureButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("📷", for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(container)
        addSubview(profile)
        contentView.addSubview(changePictureButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LabelTVC: UITableViewCell, UITextFieldDelegate {
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    let editButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("✏️", for: .normal)
        return btn
    }()
    
    let nameT: UITextField = {
        let textF = UITextField()
        textF.text = "Username"
        textF.borderStyle = .roundedRect
        
        return textF
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("💾", for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameT.delegate = self
        
        addSubview(name)
        contentView.addSubview(editButton)
        contentView.addSubview(nameT)
        contentView.addSubview(saveButton)
        nameT.isHidden = true
        saveButton.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 28
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
        label.text = "70% achieved"
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
        circleLayer.lineWidth = 5.0
        circleLayer.strokeColor = UIColor(hex: "#a9e1f9")?.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0.7
        progressLayer.strokeColor = UIColor(hex: "#3EC6FF")?.cgColor
        progressCircleView.layer.addSublayer(circleLayer)
        progressCircleView.layer.addSublayer(progressLayer)
    }
}

class SegmentTVC: UITableViewCell {
    
    let items = ["Like", "Achieved"]
    var optionList = UISegmentedControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setEditing(true, animated: true)
        
        optionList = UISegmentedControl(items: items)
        optionList.selectedSegmentIndex = 0
    
        optionList.layer.cornerRadius = 20  // Don't let background bleed
        optionList.backgroundColor = UIColor(hex: "#E8E8E8")
        
        addSubview(optionList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

class SpotListTVC: UITableViewCell {
    
    var locList = ListViewController()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        locList.notMyPage = false
        locList.viewDidLoad()
        contentView.addSubview(locList.view)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
