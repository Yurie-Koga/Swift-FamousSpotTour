//
//  MapViewController.swift
//  FamousSpotTour
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-17.
//

import UIKit
import RealmSwift
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    
    var cellId = "Cell"
    
    var locations: [Location] = []
    
    var spotTab : UICollectionView!
    
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
        
        
        let spotBarWidth = view.bounds.width - 20
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: spotBarWidth / 4, height: view.bounds.height * 0.1 - 20)
        layout.scrollDirection = .horizontal
        spotTab = UICollectionView(frame: .init(x: 10, y: view.bounds.height - (view.bounds.height * 0.15) - (super.tabBarController!.tabBar.frame.size.height + 10), width: spotBarWidth, height: view.bounds.height * 0.15), collectionViewLayout: layout)
        spotTab.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        spotTab.layer.cornerRadius = 10
        spotTab.dataSource = self
        spotTab.delegate = self
        spotTab.register(SpotTabHorizontalCVCell.self, forCellWithReuseIdentifier: cellId)
        spotTab.showsVerticalScrollIndicator = true
        
        view.addSubview(spotTab)
        
        checkLocationServices()
        
        //        print(Realm.Configuration.defaultConfiguration.fileURL!)
        updateMap()
        
        
    }
    
    func updateMap() {
        
        checkLocationServices()
        fetchLocationsOnMap(locations)
        if(locations.count > 1) {
            spotTab.isHidden = false
        } else {
            spotTab.isHidden = true
        }
        mapView.reloadInputViews()
    }
    
    func setupLocation(_ category: Int) {
        
        for location in self.realm.objects(Location.self) {
            //            if location.categoryId == category {
            locations.append(location)
            //            }
        }
    }
    
    func setupLocationSelected(_ locationId: Int) {
        locations = []
        if let location = realm.object(ofType: Location.self, forPrimaryKey: locationId) {
            locations.append(location)
        }
        spotTab.reloadData()
        updateMap()
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
    
    func fetchLocationsOnMap(_ locations: [Location]) {
        mapView.removeAnnotations(mapView.annotations)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return locations.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SpotTabHorizontalCVCell
        
        ViewController.share.fetchImage(url: URL(string: self.locations[indexPath.row].picture)!) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.spotTab.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.showImageView.image = image
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        setupLocationSelected(locations[indexPath.row].id)
    }
}
