//
//  Locations.swift
//  testMap
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-17.
//

import Foundation
import MapKit
import RealmSwift

class Location : Object {
//    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var lattitude: CLLocationDegrees = 0.0
    @objc dynamic var longtitude: CLLocationDegrees = 0.0
    
    
    init(name nameL: String, desc descriptionL: String, lattitude lattitudeL: CLLocationDegrees, longtitude longtitudeL: CLLocationDegrees) {
        name = nameL
        desc = descriptionL
        lattitude = lattitudeL
        longtitude = longtitudeL
    }
    
    override init() {
        
    }

    static var sampleLocations: [Location] {
      return [
        Location(name: "Stanley Park", desc:  "Park" , lattitude: 49.30439827058358, longtitude: -123.14418782050276),
              Location(name: "Grouse Mountain", desc:  "Park" ,lattitude: 49.370961090923075,  longtitude: -123.09845122259286),
              Location(name: "Capilano Suspension Bridge", desc:  "Park" , lattitude: 49.343021631697184, longtitude: -123.11487074843767),
              Location(name: "Gastown Vancouver Steam Clock", desc:  "Tourist attraction" , lattitude: 49.28475831932039,  longtitude: -123.10887130559915),
              Location(name: "English Bay Beach", desc: "Beach", lattitude: 49.28700833969751, longtitude: -123.14345608363126),
              Location(name: "Canada Place", desc:  "Tourist attraction", lattitude: 49.288983156191335, longtitude: -123.10994227073533),
              Location(name: "Vancouver Art Gallery", desc:  "Tourist attraction", lattitude: 49.28312862659462, longtitude: -123.12045003480563),
              Location(name: "Science World", desc:  "Tourist attraction", lattitude: 49.2735509588638, longtitude: -123.10379107669918),
              Location(name: "Harbor Centre – Vancouver Lookout", desc:  "Tourist attraction", lattitude: 49.284837234495456, longtitude: -123.11194570877227)
      ]
    }
}
