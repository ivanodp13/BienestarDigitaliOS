//
//  ViewController.swift
//  
//
//  Created by Iván Obejo on 15/01/2020.
//

import UIKit
import Alamofire
import AlamofireImage
//import SwiftyJSON

var global_app_name = ""
var global_app_icon = ""

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /*class App{
        var name: String = ""
        var use: String = ""
    }*/
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var useArray: Array<String> = []
    var iconURLArray: Array<String> = []
    
    var detailsTableViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadDataFromAPI()
    }
    
    func downloadDataFromAPI(){
        
        let url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseToday"
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header) .responseJSON { response in
            if let JSON = response.result.value{
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary]{
                    let name = item["name"] as? String
                    let use = item["use"] as? String
                    let imageURL = item["icon"] as? String
                    self.nameArray.append((name)!)
                    self.useArray.append((use) ?? "0")
                    self.iconURLArray.append((imageURL)!)
                }
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppTableViewCell
        
        cell.appName.text = self.nameArray[indexPath.row]
        cell.appUse.text = self.useArray[indexPath.row]
        
        let url = URL(string: self.iconURLArray[indexPath.row])
        cell.appIcon.af_setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app_name = nameArray[indexPath.row]
        global_app_name = app_name
        
        let app_icon = iconURLArray[indexPath.row]
        global_app_icon = app_icon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
