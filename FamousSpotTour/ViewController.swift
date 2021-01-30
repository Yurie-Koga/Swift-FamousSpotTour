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
    let store: StoreRepository = StoreRepository(name: "tags")
    
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

    func fetchTag() {
        self.store.all(completeion: { (items) in
            for item in items {
                print(item.data())
            }
        })
    }
    
    
}

