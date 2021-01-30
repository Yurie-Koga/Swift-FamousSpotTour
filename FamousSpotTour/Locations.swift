//
//  Locations.swift
//  testMap
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-17.
//

import Foundation
import MapKit
import RealmSwift
import Firebase

class Location : Object {
    
    @objc dynamic var id: Int = 0
    
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var lattitude: CLLocationDegrees = 0.0
    @objc dynamic var longtitude: CLLocationDegrees = 0.0
    
    @objc dynamic var categoryId: Int = 0
    @objc dynamic var headline: String = ""
    @objc dynamic var like: Int = 0
    @objc dynamic var dislike: Int = 0
    @objc dynamic var picture : String = ""
    var tagsId = List<Int>()
    
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var updateAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(_ location: Dictionary<String, Any>) {
        print(location)
        id = location["id"] as! Int
        name = location["name"] as! String
        desc = location["description"] as! String
        lattitude = (location["geo"] as! GeoPoint).latitude
        longtitude = (location["geo"] as! GeoPoint).longitude
        
        categoryId = location["category_id"] as! Int
        headline = location["headline"] as! String
        like = location["like"] as! Int
        dislike = location["dislike"] as! Int
        picture = location["picture"] as! String
        for tag in location["tag_ids"] as! NSArray {
            tagsId.append(tag as! Int)
        }
        createdAt = (location["created_at"] as! Timestamp).dateValue()
        updateAt = (location["updated_at"] as! Timestamp).dateValue()
    }
    
    override init() {
      
    }
}
