import Alamofire

class User_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circularImage.layer.masksToBounds = true
        circularImage.layer.cornerRadius = circularImage.bounds.width / 2
        getUserData()
    }

    @IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    
    let barButton = UIBarButtonItem()
    
    func getUserData() {
        let url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showUserData"
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                self.usernameLabel.text = json["name"]! as? String
                self.useremailLabel.text = json["email"]! as? String
            }
        }
    }
    
    @IBAction func function(_ sender: Any) {
        let token = UserDefaults.standard
        token.removeObject(forKey: "token")
        token.synchronize()
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "singOffSegue", sender: nil)
    }
   
    @objc func barButtonAction() {
        print("Button pressed")
    }

    
    
    @IBAction func unwidToUser(_ sender: UIStoryboardSegue) {}
}

