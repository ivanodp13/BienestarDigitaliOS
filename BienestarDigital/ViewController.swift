//
//  ViewController.swift
//  
//
//  Created by Iván Obejo on 15/01/2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var apps:[App] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*let instagram = App(json: <#[String : Any]#>)
        instagram.name = "Instagram"
        instagram.use = "2h"
        
        let whatsapp = App()
        whatsapp.name = "Whatsapp"
        whatsapp.use = "3h"
        
        let facebook = App()
        facebook.name = "Facebook"
        facebook.use = "1h"
        
        let safari = App()
        safari.name = "Safari"
        safari.use = "2h"
        
        let twitter = App()
        twitter.name = "Twitter"
        twitter.use = "5h"*/
        
        //apps = [instagram, whatsapp, facebook, safari, twitter]
        //getAppUseData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppTableViewCell
        
        for app in apps {
            cell.appName.text = apps[indexPath.row].name
            
            //cell.appUse.text = apps[indexPath.row].use
        }
        
        //cell.appUse.text = apps[indexPath.row].use
        //cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])
        
        return cell
    }
    
    /*func getAppUseData() {
        let url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseToday"
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header).responseJSON { response in
            
            switch(response.response?.statusCode){
                
            case 200:
                
                if let json = response.result.value as? [[String: Any]] {
                    var apps: [App] = []
                    
                    for app in json {
                        apps.append(App(json: app))
                    }
                    
                    for app in apps {
                        print(app.id)
                        print(app.name)
                        print(app.icon)
                        print(app.use)
                    }
                }
                
            case 400:
                print("Error de servidor")
            default:
                print("Tas pasao")
            }
            
            /*if let json = response.result.value as? [String: Any] {
                
            }*/
        }
    }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
