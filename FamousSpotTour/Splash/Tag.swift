//
//  Tag.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/29.
//

import Foundation
import RealmSwift

class Tag: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    init(_ data: Dictionary<String, Any>) {
        id = data["id"] as! Int
        name = data["name"] as! String
    }

    override init() {}

}
