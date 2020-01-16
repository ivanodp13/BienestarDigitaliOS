//
//  SettingTable_ViewController.swift
//  BienestarDigital
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit

class SettingTable_ViewController: UIViewController {
    
    @IBOutlet var SettingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SettingsTable.isScrollEnabled = false
    }
    
}
