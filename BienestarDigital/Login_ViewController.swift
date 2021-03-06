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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
            //self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "autoLoginSegue", sender: nil)
            print ("es true")
        }
    }


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    /// Petición al servidor para que el usuario inicie sesión. Una vez que el usuario y contraseña son correctos, se guarda el token del usuario en el UsersDefault.
    ///
    /// - Parameters:
    ///   - email: Email del usuario
    ///   - password: Contraseña del usuario
    func logIn(email: String, password: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/login")
         
        
        let json = ["email": email, "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    //print(UserDefaults.standard.value(forKey: "token") ?? 0)
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
    
    /// Función que se ejecuta al pulsar el botón de login. Hace la llamada al servidor.
    @IBAction func loginFunc(_ sender: Any) {
        if(emailTextField.text?.isEmpty ?? true || passTextField.text?.isEmpty ?? true){
            self.warningLabel.isHidden = false
        }else{
            logIn(email: emailTextField.text!, password: passTextField.text!)
        }
    }
    
    /// Función que se ejecuta al pulsar el botón de registrarse. Ejecuta un segue que lleva a la vista de registro.
    @IBAction func registerfunc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "loginToRegisterSegue", sender: nil)
    }
    
    
    /// Función que se ejecuta al pulsar el botón de recuperar contraseña. Ejecuta un segue que lleva a la vista de recuperación de contraseña.
    @IBAction func passRecovery(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "loginToPassRecovery", sender: nil)
    }
}


