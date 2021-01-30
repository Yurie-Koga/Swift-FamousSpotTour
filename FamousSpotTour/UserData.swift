//
//  UserData.swift
//  FamousSpotTour
//
//  Created by Yurie.K on 2021-01-25.
//

import Foundation

struct UserData: Codable {
    var locationId: Int
    var isVisited: Bool
    var isLike: Bool
    var isDislike: Bool
    
    static var archiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsURL.appendingPathComponent("userDatas").appendingPathExtension("plist")
        
        return archiveURL
    }
    
    static func saveToFile(userDatas: [UserData]) {
        let encoder = PropertyListEncoder()
        do {
            let encodedDatas = try encoder.encode(userDatas)
            try encodedDatas.write(to: UserData.archiveURL)
        } catch {
            print("Error encoding userDatas: \(error.localizedDescription)")
        }
    }
    
    static func loadFromFile() -> [UserData]? {
        guard let userDatas = try? Data(contentsOf: UserData.archiveURL) else { return nil }
        
        do {
            let decoder = PropertyListDecoder()
            let decodedUserData = try decoder.decode([UserData].self, from: userDatas)
            
            return decodedUserData
        } catch {
            print("Error decoding userDatas: \(error)")
            return nil
        }
    }
    
}
