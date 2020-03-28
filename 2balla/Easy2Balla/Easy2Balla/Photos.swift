//
//  Photos.swift
//  Easy2Balla
//
//  Created by apple on 3/28/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

class Photos: Codable {
    var name: String
    var message: String
    var code: Int
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case message = "Message"
        case code = "Code"
        case status = "Status"
    }
}
