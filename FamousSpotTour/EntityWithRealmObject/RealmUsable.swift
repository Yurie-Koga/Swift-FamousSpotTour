//
//  RealmUsable.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/30.
//

import Foundation
import RealmSwift

protocol RealmUsable {
    static func create() -> Realm
}

extension RealmUsable {

    static func create() -> Realm {
        var config = Realm.Configuration()
        do {
            return try Realm(configuration: config)
        } catch {
            assertionFailure("realm error: \(error)")
            config.deleteRealmIfMigrationNeeded = true
            return try! Realm(configuration: config)
        }
    }
}

struct RealmFactory: RealmUsable {}
