//
//  RestorePass_ViewController.swift
//  BienestarDigital
//
//  Created by alumnos on 14/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit
import Alamofire

class RestorePass_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.WarningLabel.isHidden = true
        sendEmailButton.layer.cornerRadius = 5
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var WarningLabel: UILabel!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    
    /// Petición para recuperar contraseña mediante email.
    ///
    /// - Parameter email: email del usuario al que se enviará la nueva contraseña.
    func RestorePass(email: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/passrestore")
        
        let json = ["_method": "PUT", "email": email]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                self.performSegue(withIdentifier: "PassRestoreSegue", sender: nil)
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
    
    /// Email del usuario que quiere recuperar la contraseña.
    @IBAction func RestorePassFunction(_ sender: Any) {
        RestorePass(email: emailTextField.text!)
    }
    
    /// Botón para volver a la vista de login.
    @IBAction func loginfunc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "loginFromRestore", sender: nil)
    }
}

