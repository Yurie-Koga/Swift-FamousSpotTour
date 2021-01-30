//
//  UseCase.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/29.
//

import Foundation
import RealmSwift
import Firebase

protocol UseCaseDelegate {

    /// Confirm Entity has more than 1 record.
    /// - Parameter Entity: The type of the objects to be returned.
    func has<Element: Object>(_ Entity: Element.Type) -> Bool

    /// Do something.
    /// - Parameter completeion: run function after fetching finish.
    func run(completeion: @escaping () -> Void)
}


struct SplashUseCase: UseCaseDelegate {

    let realm = try! Realm()
    let store = StoreRepository()


    func run(completeion: @escaping () -> Void) {
        if self.has(LastUpdated.self) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                self.store.updateIfNeed()
                completeion()
            }
        } else {
            self.deleteAll()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.store.fetchAndSave()
                completeion()
            }
        }
    }

    func has<Element: Object>(_ Entity: Element.Type) -> Bool {
        if self.realm.objects(Entity.self).count > 0 {
            return true
        }
        return false
    }

    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }

}
