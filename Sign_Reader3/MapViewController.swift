//
//  MapViewController.swift
//  Sign_Reader3
//
//  Created by Joseph Tooker on 11/22/21.
//

import CoreLocation
import GoogleMaps
import GooglePlaces
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    var location: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        placesClient = GMSPlacesClient.shared()
    
        
        location = CLLocationCoordinate2D(latitude: -33.869405, longitude: 151.199)
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoomLevel)
        mapView = GMSMapView(frame: .zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func mapView(mapView: GMSMapView!, didLongPressAt coordinate: CLLocationCoordinate2D) {
         let marker = GMSMarker(position: coordinate)
         marker.title = "Hello World"
         marker.map = mapView
    }


}
