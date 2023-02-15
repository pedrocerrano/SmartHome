//
//  DeviceTableViewCell.swift
//  SmartHome
//
//  Created by iMac Pro on 2/15/23.
//

import UIKit

protocol DeviceTableViewCellDelegate: AnyObject {
    func isOnSwitchToggled(cell: DeviceTableViewCell)
} //: PROTOCOL


class DeviceTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceIsOnSwitch: UISwitch!
    
    
    //MARK: - PROPERTIES
    weak var delegate: DeviceTableViewCellDelegate?
    
    
    //MARK: - FUNCTIONS
    func updateViews(device: Device) {
        deviceNameLabel.text  = device.name
        deviceIsOnSwitch.isOn = device.isOn
    } //: UPDATE
    
    
    //MARK: - ACTIONS
    @IBAction func isOnSwitchToggled(_ sender: Any) {
        delegate?.isOnSwitchToggled(cell: self)
    } //: SWITCH TOGGLED
    
} //: CLASS
