//
//  ViewController.swift
//  BienestarDigital
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit
import Alamofire

class Login_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.warningLabel.isHidden = true
        loginButton.layer.cornerRadius = 5
        self.emailTextField.text = "ivanobejo@hotmail.es"
        self.passTextField.text = "123"
    }


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    func logIn(email: String, password: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/login")
         
        
        let json = ["email": email, "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
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
        }
    }
    @IBAction func loginFunc(_ sender: Any) {
        if(emailTextField.text?.isEmpty ?? true || passTextField.text?.isEmpty ?? true){
            self.warningLabel.isHidden = false
        }else{
            logIn(email: emailTextField.text!, password: passTextField.text!)
        }
    }
    
}


