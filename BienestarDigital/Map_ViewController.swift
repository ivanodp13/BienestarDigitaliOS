//
//  Map_ViewController.swift
//  BienestarDigital
//
//  Created by Iván Obejo on 18/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation


class Map_ViewController: UIViewController, CLLocationManagerDelegate {
    
    var jsonArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    
    @IBOutlet weak var mapView: MKMapView!
     let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadDataFromAPI()
        
        //let localizacion = CLLocationCoordinate2DMake
        //print(localizacion)
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        let regionRadius: CLLocationDistance = 4000.0
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    
    
    func downloadDataFromAPI(){
        
        let url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showUseLocations"
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header) .responseJSON { response in
            if let JSON = response.result.value{
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary]{
                    let latitude = item["latitude"] as? String
                    let longitude = item["longitude"] as? String
                    
                    self.latitudeArray.append((latitude ?? "0"))
                    self.longitudeArray.append((longitude ?? "0"))
                }
                if(response.response?.statusCode == 200){
                    self.createAnnotations()
                }
            }
        }
    }
    
    func createAnnotations(/*locations: [[String: Any]]*/){
        var locations = 0
        let latitudes = latitudeArray.count
        let longitudes = longitudeArray.count
        
        
        
        if(latitudes == longitudes){
            locations = latitudes-1
        }
        for locations in 0...locations{
            let locationsNumber = String(locations+1)
            let annotation = MKPointAnnotation()
            annotation.title = "Localización "+locationsNumber
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudeArray[locations]) as! CLLocationDegrees, longitude: CLLocationDegrees(longitudeArray[locations]) as! CLLocationDegrees)
            self.mapView.addAnnotation(annotation)
        }
        
    }
}


