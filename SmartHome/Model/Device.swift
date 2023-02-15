//
//  Device.swift
//  SmartHome
//
//  Created by iMac Pro on 2/15/23.
//

import Foundation

class Device {
    
    let name: String
    var isOn: Bool
    let id: UUID
    
    init(name: String, isOn: Bool = false, id: UUID = UUID()) {
        self.name = name
        self.isOn = isOn
        self.id = id
    } //: MEMBERWISE INITIALIZER
    
} //: CLASS
