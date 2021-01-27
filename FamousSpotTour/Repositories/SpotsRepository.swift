//
//  SpotsRepository.swift
//  FamousSpotTour
//
//  Created by Takayasu Nasu on 2021/01/19.
//

import Foundation
import FirebaseFirestore

struct SpotsRepository {

  let name: String = "spots"
  private var databaseStore: Firestore = Firestore.firestore()

  // Get All Spots data from Firebase.
  func find(by id: String, completeion: @escaping ([String: Any]) -> Void) {
    databaseStore.collection(self.name).document(id).getDocument{ (document, error) in
      if let error = error {
        fatalError("\(error)")
      }
      guard let data = document?.data() else { return }
      completeion(data)
    }
  }

  // Get Specific Spots data from Firebase by id.
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
