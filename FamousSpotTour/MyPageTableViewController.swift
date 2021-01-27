//
//  MyPageTableViewController.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-25.
//

import UIKit

class MyPageTableViewController: UITableViewController {

    let stepProfile: [String] = ["Picture","Name","Progress"]
    
    let cellPic = "cellPic"
    let cellNam = "cellNam"
    let cellProg = "cellProg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Page"
        view.backgroundColor = .white
        
        
        tableView.register(PictureTVC.self, forCellReuseIdentifier: cellPic)
        tableView.register(LabelTVC.self, forCellReuseIdentifier: cellNam)
        tableView.register(ProgressTVC.self, forCellReuseIdentifier: cellProg)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: CGFloat.leastNormalMagnitude))
        tableView.separatorColor = .clear;
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // display tab bar
        tabBarController?.tabBar.isHidden = false
        // display nav bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepProfile.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageWidth = view.bounds.width * 0.4
        
        switch stepProfile[indexPath.row] {
        case "Picture":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPic, for: indexPath) as! PictureTVC
            cell.container.backgroundColor = UIColor(hex: "#3EC6FF")
            cell.container.frame = .init(x: 0, y: 0, width: view.bounds.width, height: imageWidth)
            cell.profile.frame = .init(x: view.bounds.width / 2 - (imageWidth / 2), y: imageWidth * 0.3
                                , width: imageWidth, height: imageWidth)
            cell.profile.layer.cornerRadius = imageWidth / 2
            return cell
        case "Name":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellNam, for: indexPath) as! LabelTVC
            cell.name.frame = .init(x: 0 , y: 0, width: view.bounds.width, height: view.bounds.width * 0.2)
            cell.name.textAlignment = .center
            return cell
        case "Progress":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellProg, for: indexPath) as! ProgressTVC
            let path = UIBezierPath(arcCenter: CGPoint(x: view.bounds.width / 2, y: cell.bounds.height / 2), radius: imageWidth / 2, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
            cell.circleLayer.path = path.cgPath
            cell.progressLayer.path = path.cgPath
            
            cell.stackV.centerXYin(cell)
            cell.todo.font = .boldSystemFont(ofSize: imageWidth / 6)
            cell.slash.font = .boldSystemFont(ofSize: imageWidth / 6)
            cell.did.font = .boldSystemFont(ofSize: imageWidth / 6)
            cell.percent.font = .systemFont(ofSize: imageWidth / 12)
            return cell
        default:
            return UITableViewCell()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        switch stepProfile[indexPath.row] {
        case "Picture":
            height = CGFloat.init(view.bounds.width * 0.4 + (view.bounds.width * 0.4) * 0.3)
        case "Name":
            height = CGFloat.init(view.bounds.width * 0.2)
        case "Progress":
            height = CGFloat.init(view.bounds.width * 0.5)
        default:
            height = 10
        }
        
        return height
    }
    
    

}
