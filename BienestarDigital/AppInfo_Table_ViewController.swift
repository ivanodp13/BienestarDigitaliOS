import UIKit
import Alamofire

var global_app_id = "0"

class AppInfo_Table_ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        downloadDataFromAPI()
        
        self.detailsTable.reloadData()
    }
    
    @IBOutlet weak var totalUseLabel: UILabel!
    @IBOutlet weak var todayUseLabel: UILabel!
    @IBOutlet weak var yesterdayUseLabel: UILabel!
    @IBOutlet weak var byUseLabel: UILabel!
    

    @IBOutlet var detailsTable: UITableView!
    
    var jsonArray: NSArray?
    var todayUseString: String = ""
    var yesterdayUseString: String = ""
    var byUseString: String = ""
    var totalUseString: String = ""
    var idString: String = ""
    
    func downloadDataFromAPI(){
        
        let url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/appUseDetails/"+global_app_name
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header) .responseJSON { response in
            if let JSON = response.result.value{
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary]{
                    let todayUse = item["todayUse"] as? String
                    let yesterdayUse = item["yesterdayUse"] as? String
                    let byUse = item["BYUse"] as? String
                    let totalUse = item["TotalUse"] as? String
                    let id = item["id"] as? String
                    self.todayUseString = todayUse ?? "Sin uso"
                    self.yesterdayUseString = yesterdayUse ?? "Sin uso"
                    self.byUseString = byUse ?? "Sin uso"
                    self.totalUseString = totalUse ?? "Sin uso"
                    self.idString = id ?? ""
                    
                    global_app_id = self.idString
                    self.todayUseLabel.text = self.todayUseString
                    self.totalUseLabel.text = self.totalUseString
                    self.yesterdayUseLabel.text = self.yesterdayUseString
                    self.byUseLabel.text = self.byUseString
                    
                }
            }
        }
    }
    
}
