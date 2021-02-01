//
//  LastUpdate.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/29.
//

import Foundation
import RealmSwift
import Firebase

class LastUpdated: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var lastUpdatedAt: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }

    init(_ data: Dictionary<String, Any>) {
        self.id = data["id"] as! Int
        lastUpdatedAt = (data["last_updated_at"] as! Timestamp).dateValue()
    }

    override init() {}

}
