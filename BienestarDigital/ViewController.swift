//
//  ViewController.swift
//  
//
//  Created by Iván Obejo on 15/01/2020.
//

import UIKit
import Alamofire
import AlamofireImage
import UserNotifications

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
    var maxTimeArray: Array<String> = []
    var sUseArray: Array<String> = []
    
    var detailsTableViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (autorizado, error) in
            if autorizado {
                print("Permiso concedido")
            } else {
                print("Permiso denegado")
            }
        }        
        downloadDataFromAPI()
    }
    
    
    /// Realiza una petición al servidor a traves de la url que aparece abajo. Una vez recibidos los datos introduce los datos en arrays.
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
                    let sMaxUse = item["maxTime"] as? String
                    let sUse = item["seconds"] as? String
                    self.nameArray.append((name)!)
                    self.useArray.append((use) ?? "0")
                    self.iconURLArray.append((imageURL)!)
                    self.maxTimeArray.append((sMaxUse)!)
                    self.sUseArray.append((sUse)!)
                }
                self.tableView.reloadData()
                self.createNotification()
                
            }
        }
    }
    
    
    /// Calcula el numero de filas que tendrá la tabla.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    /// Rellena cada una de las celdas con los datos que correspondan.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppTableViewCell
        
        cell.appName.text = self.nameArray[indexPath.row]
        cell.appUse.text = self.useArray[indexPath.row]
        
        let url = URL(string: self.iconURLArray[indexPath.row])
        cell.appIcon.af_setImage(withURL: url!)
        
        return cell
    }
    
    
    /// Guarda en una variable global los datos de la celda seleccionada.
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
    
    func createNotification(){
        var x = 0
        for i in maxTimeArray {
            print(i)
            print("vs")
            print(sUseArray[x])
            
            if (Int(i) ?? 0 > Int(sUseArray[x]) ?? 0) {
                let contenido = UNMutableNotificationContent()
                contenido.title = "¡Cuidado!"
                contenido.body = "Has superado el tiempo de uso para "+nameArray[x]
                contenido.sound = UNNotificationSound.default
                contenido.badge = 3
                
                let disparador = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let peticion = UNNotificationRequest(identifier: "miNotificacion", content: contenido, trigger: disparador)
                
                UNUserNotificationCenter.current().add(peticion, withCompletionHandler: nil)
            }
            /*if(Int(i) ?? 0) < (useArray[x]){
            }*/
        x += 1
        }
    }
}
