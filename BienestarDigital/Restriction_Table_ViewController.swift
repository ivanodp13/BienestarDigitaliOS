import UIKit

var global_MaxTime_Switch: Bool = false
var global_FromToTime_Switch: Bool = false

class Restriction_Table_ViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.section1Cell2.isHidden=true
        self.section2Cell2.isHidden=true
        self.section2Cell3.isHidden=true
        
        /*-----First datePicker-----*/
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(self.MaxtimeChanged(datePicker:)), for: .valueChanged)
        datePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let date = dateFormatter.date(from: "00:00")
        datePicker?.date = date!
        
        let firstDateChanged = UITapGestureRecognizer(target: self, action: #selector(Restriction_Table_ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(firstDateChanged)
        
        maxTimeTextField.inputView = datePicker
        
        /*-----Second datePicker-----*/
        secondDatePicker = UIDatePicker()
        secondDatePicker?.datePickerMode = .time
        secondDatePicker?.addTarget(self, action: #selector(self.FromtimeChanged(datePicker:)), for: .valueChanged)
        secondDatePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let SeconddateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let Seconddate = dateFormatter.date(from: "00:00")
        secondDatePicker?.date = date!
        
        let secondDateChanged = UITapGestureRecognizer(target: self, action: #selector(Restriction_Table_ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(secondDateChanged)
        
        fromTimeTextField.inputView = secondDatePicker
        
        
        /*-----Third datePicker-----*/
        thirdDatePicker = UIDatePicker()
        thirdDatePicker?.datePickerMode = .time
        thirdDatePicker?.addTarget(self, action: #selector(self.TotimeChanged(datePicker:)), for: .valueChanged)
        thirdDatePicker?.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        
        let ThirddateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        
        let Thirddate = dateFormatter.date(from: "00:00")
        thirdDatePicker?.date = date!
        
        
        
        let thirdDateChanged = UITapGestureRecognizer(target: self, action: #selector(Restriction_Table_ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(thirdDateChanged)
        
        toTimeTextField.inputView = thirdDatePicker
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var maxTimeTextField: UITextField!
    @IBOutlet weak var fromTimeTextField: UITextField!
    @IBOutlet weak var toTimeTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    private var secondDatePicker: UIDatePicker?
    private var thirdDatePicker: UIDatePicker?
    
    @IBOutlet weak var maxTimeSwitch: UISwitch!
    @IBOutlet weak var fromToTimeSwitch: UISwitch!
    
    @IBOutlet weak var section1Cell2: UITableViewCell!
    
    @IBOutlet weak var section2Cell2: UITableViewCell!
    @IBOutlet weak var section2Cell3: UITableViewCell!
    
    
    /// Al tocar fuera del Picker se cerrará.
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    /// Switch que muestra el campo de máximo tiempo de uso.
    @IBAction func maxTimeSwitchFunc(_ sender: Any) {
        if maxTimeSwitch.isOn{
            self.section1Cell2.isHidden=false
            global_MaxTime_Switch = true
            global_maxTimeLabel = maxTimeTextField.text!
        }else{
            self.section1Cell2.isHidden=true
            global_MaxTime_Switch = false
            global_maxTimeLabel = ""
        }
            
    }
    
    /// Switch que muestra el campo de rango de uso.
    @IBAction func fromToTimeSwitchFunc(_ sender: Any) {
        if fromToTimeSwitch.isOn{
            global_toTimeLabel = toTimeTextField.text!
            global_fromTimeLabel = fromTimeTextField.text!
            self.section2Cell2.isHidden=false
            self.section2Cell3.isHidden=false
            global_FromToTime_Switch = true
        }else{
            global_toTimeLabel = ""
            global_fromTimeLabel = ""
            self.section2Cell2.isHidden=true
            self.section2Cell3.isHidden=true
            global_FromToTime_Switch = false
        }
    }
    
    /// Obtiene el valor del Picker de tiempo máximo.
    @objc func MaxtimeChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        maxTimeTextField.text = dateFormatter.string(from: datePicker.date)
        global_maxTimeLabel = maxTimeTextField.text!
        //view.endEditing(true)
    }
    
    
    /// Obtiene el valor del Picker de tiempo inicial.
    @objc func FromtimeChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        fromTimeTextField.text = dateFormatter.string(from: datePicker.date)
        global_fromTimeLabel = fromTimeTextField.text!
        //view.endEditing(true)
    }
    
    
    /// Obtiene el valor del Picker de tiempo final.
    @objc func TotimeChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        toTimeTextField.text = dateFormatter.string(from: datePicker.date)
        global_toTimeLabel = toTimeTextField.text!
        //view.endEditing(true)
    }
    
}
