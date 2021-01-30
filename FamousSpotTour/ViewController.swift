//
//  ViewController.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/14.
//

import UIKit
import RealmSwift
import Firebase

class ViewController: UIViewController {
    
    static let share = ViewController()
    
    let spotsRepository: SpotsRepository = SpotsRepository()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = .white
        
        
    }
    
    func fetchSpotFromRepository() {
        self.spotsRepository.all { (items) in
            try! self.realm.write() {
                for item in items {
                    let newLocation = Location(item.data())
                    self.realm.add(newLocation, update: .modified)
                }
            }
        }
    }
    
    // fetch single record
    func fetchSingleSpotFromRepository(by id: String) {
        self.spotsRepository.find(by: id, completeion: { (item) in
            try! self.realm.write() {
                let newLocation = Location(item)
                self.realm.add(newLocation, update: .modified)
//                if let location = self.realm.object(ofType: Location.self, forPrimaryKey: newLocation.id) {
//                    print("after fetched to realm: \(location)")
//                }
            }
            
        })
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url)
           { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
}

