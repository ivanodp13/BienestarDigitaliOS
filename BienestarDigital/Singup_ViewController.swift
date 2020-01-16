import UIKit
import Alamofire

class Singup_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.warningLabel.isHidden = true
        sigupButton.layer.cornerRadius = 5
    }
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var sigupButton: UIButton!
    
    
    func register(name: String, email: String, password: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/register")
        
        
        let json = ["name": name, "email": email, "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    self.performSegue(withIdentifier: "RegisterSegue", sender: nil)
                    print(UserDefaults.standard.value(forKey: "token") ?? 0)
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    let warning = json["message"] as! String
                    self.warningLabel.text = warning
                    self.warningLabel.isHidden = false
                }
            default:
                print("DEFAULT")
            }
            
            //print(response)
        }
    }
    @IBAction func RegisterFunc(_ sender: Any) {
        if(usernameTextField.text?.isEmpty ?? true || emailTextField.text?.isEmpty ?? true || passTextField.text?.isEmpty ?? true){
            self.warningLabel.isHidden = false
        }else{
            register(name: usernameTextField.text!, email: emailTextField.text!, password: passTextField.text!)
        }
    }
}
