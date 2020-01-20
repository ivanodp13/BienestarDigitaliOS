import UIKit
import Alamofire

var global_maxTimeLabel  = ""
var global_fromTimeLabel  = ""
var global_toTimeLabel  = ""

class NewRestriction_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AddRestrictionButton.layer.cornerRadius = 5
        appNameLabel.text = global_app_name
        warningLabel.isHidden = true
        
    }
    @IBOutlet weak var AddRestrictionButton: UIButton!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBAction func AddRestrictionFunc(_ sender: Any) {
        if(global_MaxTime_Switch == false) &&  (global_FromToTime_Switch == false){
            warningLabel.isHidden = false
        }else{
           addRestriction(maxTime: global_maxTimeLabel, fromTime: global_fromTimeLabel,toTime: global_toTimeLabel)
        }
    }
    
    func addRestriction(maxTime: String, fromTime: String, toTime: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/restrictions/"+global_app_id)
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let token = ["Authorization" : user_token]
        
        let json = ["MaxTime": global_maxTimeLabel, "InitTime": global_fromTimeLabel, "EndTime": global_toTimeLabel]
        
        if(global_MaxTime_Switch == false){
            global_maxTimeLabel = ""
        }else if (global_FromToTime_Switch == false){
             global_fromTimeLabel  = ""
             global_toTimeLabel  = ""
        }
        
        if(global_MaxTime_Switch == true){
            let json = ["MaxTime": maxTime]
        }else if (global_FromToTime_Switch == true){
            let json = ["InitTime": fromTime, "EndTime": toTime]
        }
        
        if (global_MaxTime_Switch == true) && (global_FromToTime_Switch == true){
            let json = ["MaxTime": maxTime, "InitTime": fromTime, "EndTime": toTime]
        }
        
        if (global_MaxTime_Switch == false) && (global_FromToTime_Switch == false){
            global_maxTimeLabel = ""
            global_fromTimeLabel  = ""
            global_toTimeLabel  = ""
        }
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: token).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    self.performSegue(withIdentifier: "unwindToAppDetail", sender: nil)
                    print("guardado")
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    //let warning = json["message"] as! String
                    print("error")
                    
                }
            default:
                print("DEFAULT")
            }
        }
    }
    
}
