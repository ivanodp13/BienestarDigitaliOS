//
//  App.swift
//  BienestarDigital
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import Foundation

class App{
    var id: Int
    var name: String
    var icon: String
    var use: Int
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        icon = json["icon"] as? String ?? ""
        use = json["use"] as? Int ?? 0
    }
}
