//
//  EditPassword_ViewController.swift
//  BienestarDigital
//
//  Created by Iván Obejo on 16/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit
import Alamofire

class EditPassword_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.warningLabel.isHidden = true
        self.WarningLabel.isHidden = true
        saveButton.layer.cornerRadius = 5
    }
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var newPassVerify: UITextField!
    @IBOutlet weak var WarningLabel: UILabel!
    
    func EditPass(currentPassword: String, newPassword: String, confirmPassword: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/passedit")
        
        let json = ["_method": "PUT", "currentPassword": currentPassword, "newPassword": newPassword, "confirmPassword": confirmPassword]
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url!, method: .post, parameters: json, headers: header).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                self.performSegue(withIdentifier: "unwidToUser", sender: nil)
            case 401:
                if let json = response.result.value as? [String: Any] {
                    let warning = json["message"] as! String
                    self.WarningLabel.text = warning
                    self.WarningLabel.isHidden = false
                }
            default:
                print("DEFAULT")
            }
        }
    }
    
    @IBAction func EditPassFunc(_ sender: Any) {
        EditPass(currentPassword: currentPass.text!, newPassword: newPass.text! , confirmPassword: newPassVerify.text!)
    }
}
