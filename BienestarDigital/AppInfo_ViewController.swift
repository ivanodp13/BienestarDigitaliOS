import UIKit
import Alamofire
import AlamofireImage

var global_todayUseString: String = ""
var global_yesterdayUseString: String = ""
var global_byUseString: String = ""
var global_totalUseString: String = ""
var global_id: String = ""


class AppInfo_ViewController: UIViewController {
    
    enum Segues {
        static let toTable = "toTable"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appIcon.layer.cornerRadius = 30
        restrictionButton.layer.cornerRadius = 5
        appName.text = global_app_name
        let url = URL(string: global_app_icon)
        appIcon.af_setImage(withURL: url!)
        downloadDataFromAPI()
        
        
        
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var restrictionButton: UIButton!
    @IBOutlet weak var appName: UILabel!
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
                    
                    global_todayUseString = self.todayUseString
                    global_yesterdayUseString = self.yesterdayUseString
                    global_byUseString = self.byUseString
                    global_totalUseString = self.totalUseString
                    global_id = self.idString
                }
            }
        }
    }
}
