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
    
    static var archiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsURL.appendingPathComponent("userDatas").appendingPathExtension("plist")
        print(archiveURL)
        return archiveURL
    }
    
    static var sampleUserData: [UserData] = [
        UserData(locationId: 1, isVisited: false),
    ]
    
    static func saveToFile(userDatas: [UserData]) {
        let encoder = PropertyListEncoder()
        print(userDatas)
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
            print(decodedUserData)
            return decodedUserData
        } catch {
            print("Error decoding userDatas: \(error)")
            return nil
        }
    }
    
}

struct PersonalUserData: Codable {
    var username: String
    var userPicture: Data
    
    static var archiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsURL.appendingPathComponent("personalUserData").appendingPathExtension("plist")
        print(archiveURL)
        return archiveURL
    }
    
    static var defaultUserData: PersonalUserData =
        PersonalUserData(username: "Username", userPicture: Data())
    
    
    static func saveToFile(userDatas: PersonalUserData) {
        let encoder = PropertyListEncoder()
        print(userDatas)
        do {
            let encodedDatas = try encoder.encode(userDatas)
            try encodedDatas.write(to: PersonalUserData.archiveURL)
        } catch {
            print("Error encoding userDatas: \(error.localizedDescription)")
        }
    }
    
    static func loadFromFile() -> PersonalUserData? {
        guard let personalUserData = try? Data(contentsOf: PersonalUserData.archiveURL) else { return nil }
        
        do {
            let decoder = PropertyListDecoder()
            let decodedUserData = try decoder.decode(PersonalUserData.self, from: personalUserData)
            print(decodedUserData)
            return decodedUserData
        } catch {
            print("Error decoding userDatas: \(error)")
            return nil
        }
    }
    
}
