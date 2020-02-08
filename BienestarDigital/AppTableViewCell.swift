//
//  AppTableViewCell.swift
//  BienestarDigital
//
//  Created by Iván Obejo on 15/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import UIKit

/// Celda personalizada de la lista de apps
class AppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appUse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        appIcon.layer.cornerRadius = 20
    }

}
