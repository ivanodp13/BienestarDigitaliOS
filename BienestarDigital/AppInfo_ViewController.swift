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
        //downloadDataFromAPI()
        
        
        
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
    
@IBAction func unwidToAppDetail(_ sender: UIStoryboardSegue) {}
}
