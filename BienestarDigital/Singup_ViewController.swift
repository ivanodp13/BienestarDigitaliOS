import UIKit
import Alamofire

class Singup_ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.warningLabel.isHidden = true
        sigupButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var sigupButton: UIButton!
    
    var text = ""
    
    
    /// Petición al servidor para que el usuario Se registre. Una vez que el usuario se ha registrado de forma satisfactoria, se guarda el token del usuario en el UsersDefault.
    ///
    /// - Parameters:
    ///   - name: nombre del usuario
    ///   - email: email del usuario
    ///   - password: contraseña del usuario
    func register(name: String, email: String, password: String) {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/register")
        
        
        let json = ["name": name, "email": email, "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    self.usageImport()
                    self.appsImport()
                    //self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "RegisterSegue", sender: nil)
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
            
            //print(response)
        }
    }
    
    /// Petición para la importación de los usos de la app.
    func usageImport() {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/usageimport")
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        let file = usagesProvider()
        
        do {
            self.text = try String(contentsOf: file, encoding: .utf8)
            //print("Texto: \(text)")
        } catch {
            print("Error al leer fichero")
        }
        
        let json = ["data": text]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    print("uso de apps imporatdos")
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    print("error")
                }
            default:
                print("DEFAULT")
            }
            
            //print(response)
        }
        
    }
    
    /// Petición para la importaciónla lista de apps.
    func appsImport() {
        let url = URL(string: "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/appsimport")
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        let file = appsProvider()
        
        do {
            self.text = try String(contentsOf: file, encoding: .utf8)
            //print("Texto: \(text)")
        } catch {
            print("Error al leer fichero")
        }
        
        let json = ["data": text]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            switch (response.response?.statusCode) {
            case 200:
                if let json = response.result.value as? [String: Any] {
                    print("importacion de apps completada")
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    print("error")
                }
            default:
                print("DEFAULT")
            }
            
            //print(response)
        }
        
    }
    
    
    
    /// Botón que realiza la peticion de registrar.
    @IBAction func RegisterFunc(_ sender: Any) {
        if(usernameTextField.text?.isEmpty ?? true || emailTextField.text?.isEmpty ?? true || passTextField.text?.isEmpty ?? true){
            self.warningLabel.isHidden = false
        }else{
            let file = usagesProvider()
            print(file)
            register(name: usernameTextField.text!, email: emailTextField.text!, password: passTextField.text!)
        }
    }
    
    /// Botón que ejecuta un Segue que lleva a la vista de login.
    @IBAction func loginfunc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "registerToLogin", sender: nil)
    }
    
    func usagesProvider() -> URL{
        let name = "usage.csv"
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let rute = directory.first?.appendingPathComponent(name)
        
        return rute!
        
    }
    
    func appsProvider() -> URL{
        let name = "appsData.csv"
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let rute = directory.first?.appendingPathComponent(name)
        
        return rute!
        
    }
    
}
