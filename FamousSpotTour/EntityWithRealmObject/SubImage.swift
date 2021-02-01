//
//  SubImage.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/29.
//

import Foundation
import RealmSwift

class SubImage: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    init(_ data: Dictionary<String, Any>) {
        self.id = data["id"] as! Int
        self.name = data["name"] as! String
        self.url = data["url"] as! String
    }

    override init() {}

}
