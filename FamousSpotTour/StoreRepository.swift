//
//  StoreRepository.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/28.
//

import Foundation
import FirebaseFirestore

struct StoreRepository {

  let name: String

  init(name: String) {
    self.name = name
  }

  init() {
    self.name = "spots"
  }

  private var databaseStore: Firestore = Firestore.firestore()


  /// Get specific data from Firebase by document id.
  /// - Parameters:
  ///   - id: document id.
  ///   - completeion: closure
  func find(by id: String, completeion: @escaping ([String: Any]) -> Void) {
    databaseStore.collection(self.name).document(id).getDocument{ (document, error) in
      if let error = error {
        fatalError("\(error)")
      }
      guard let data = document?.data() else { return }
      completeion(data)
    }
  }

  /// Get All data from Firebase
  /// - Parameter completeion: closure.
  func all(completeion: @escaping ([QueryDocumentSnapshot]) -> Void) {

    databaseStore.collection(self.name).getDocuments{ (documents, error) in
      if let error = error {
        fatalError("\(error)")
      }
      guard let data = documents else { return }
      completeion(data.documents)
    }
  }
}
