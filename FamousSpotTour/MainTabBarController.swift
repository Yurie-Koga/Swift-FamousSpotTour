//
//  MainTabBarController.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-19.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let map = MapViewController()
    
    let list = UIViewController()
    
    let myPage = UIViewController()
    
    let settings = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [map,list,myPage,settings]
        let itemsVC = items.map { createVC($0) }
        
        self.viewControllers = itemsVC.map { UINavigationController(rootViewController: $0) }
        
    }
    
    func createVC(_ sender: Any) -> UIViewController {
        let viewC = sender
        
        switch viewC {
        case let v as MapViewController:
            v.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map")! , selectedImage: nil)
            return v
        case let v as UIViewController:
            v.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.dash")! , selectedImage: nil)
            return v
        default:
            
            return UIViewController()
        }
        
        
    }
    
}
