//
//  MapViewController.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-17.
//

import UIKit
import RealmSwift
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    
    lazy var locations: Results<Location> = { self.realm.objects(Location.self) }()
    
    let realm = try! Realm()
    
    @objc let comeBack : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Come Back", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.frame = .init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        mapView.delegate = self
        
        checkLocationServices()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        populateDefaultLocations()
        
        fetchLocationsOnMap(locations)
    }
    
    private func populateDefaultLocations() {
        if locations.count == 0 { // 1
            try! realm.write() { // 2
                let defaultLocations = Location.self// 3
                
                for location in defaultLocations.sampleLocations { // 4
                    realm.add(location)
                }
            }
            
            locations = realm.objects(Location.self) // 5
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    @objc func comeBackMethod() {
        let coordinateRegion = MKCoordinateRegion(center: mapView.centerCoordinate , latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied: // Show alert telling users how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted: // Show an alert letting them know what’s up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func fetchLocationsOnMap(_ locations: Results<Location>) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                                                                location.lattitude, longitude: location.longtitude)
            
            mapView.addAnnotation(annotations)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        callRoute(origin: mapView.userLocation.coordinate, destine: view.annotation!.coordinate)
        
        let coordinateRegion = MKCoordinateRegion(center: view.annotation!.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func callRoute(origin: CLLocationCoordinate2D, destine: CLLocationCoordinate2D) {
        //clean old locations
        mapView.removeOverlays(mapView.overlays)
        //create two dummy locations
        let loc1 = CLLocationCoordinate2D(latitude: origin.latitude, longitude: origin.longitude)
        let loc2 = CLLocationCoordinate2D(latitude: destine.latitude, longitude: destine.longitude)
        
        //find route
        showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
    }
    
    //route
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            //            for getting just one route
            
            if let route = unwrappedResponse.routes.first {
                //show on map
                mapView.addOverlay(route.polyline)
                //set the map area to show the route
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
    
    //this delegate function is for displaying the route overlay and styling it
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
}


import CommonCrypto

extension String {
    
    func sha512() -> Data? {
        let stringData = data(using: String.Encoding.utf8)!
        var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { resultBytes in
            stringData.withUnsafeBytes { stringBytes in CC_SHA512(stringBytes, CC_LONG(stringData.count), resultBytes)}
        }
        return result
    }
    
}
