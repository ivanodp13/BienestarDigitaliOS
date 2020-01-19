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


class Location {
    var latitude: String?
    var longitude: String?
}

class Map_ViewController: UIViewController {
    
    var jsonArray: NSArray?
    var latitudeArray: Array<String> = []
    var longitudeArray: Array<String> = []
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadDataFromAPI()
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
            locations = latitudes
        }
        var i = 0
        
        print(latitudeArray[i])
        
        let annotation2 = MKPointAnnotation()
        annotation2.title = "prueba"
        annotation2.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudeArray[1]) as! CLLocationDegrees,
                                                           longitude: CLLocationDegrees(longitudeArray[1]) as! CLLocationDegrees)
        self.mapView.addAnnotation(annotation2)
        
    }
}
