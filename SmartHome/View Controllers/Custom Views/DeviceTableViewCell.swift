//
//  DeviceTableViewCell.swift
//  SmartHome
//
//  Created by iMac Pro on 2/15/23.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceIsOnSwitch: UISwitch!
    
    
    //MARK: - PROPERTIES
    
    
    
    //MARK: - FUNCTIONS
    func updateViews() {
        
    }
    
    
    //MARK: - ACTIONS
    @IBAction func isOnSwitchToggled(_ sender: Any) {
        
    } //: SWITCH TOGGLED
    
} //: CLASS
