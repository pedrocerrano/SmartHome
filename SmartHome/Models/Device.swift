//
//  Device.swift
//  SmartHome
//
//  Created by Trevor Adcock on 12/21/21.
//

import Foundation

/// A simple model class representing a device
class Device: Codable {
    
    /// The name of the device
    let name: String
    /// A boolean indicating if the device is currently on
    var isOn: Bool
    
    /// Initializes a new device with the given `name` and `isOn` value
    /// - Parameters:
    ///   - name: The name of the device
    ///   - isOn: A boolean indicating if the device is currently on
    init(text: String, isOn: Bool = false) {
        self.name = text
        self.isOn = isOn
    }
}
