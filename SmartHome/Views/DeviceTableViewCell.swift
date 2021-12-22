//
//  deviceTableViewCell.swift
//  SmartHome
//
//  Created by Trevor Adcock on 12/21/21.
//

import UIKit

/// A delegate protocol for the `DeviceTableViewCell` which reports signals when the cells toggle value is changed
protocol DeviceTableViewCellDelegate: AnyObject {
    
    /// A delegate method signaling when the cell's switch is toggled
    func isOnSwitchToggled(_ cell: DeviceTableViewCell)
}

/// A custom table view cell used for rendering the contents of a `Device` instance
class DeviceTableViewCell: UITableViewCell {
    
    /// A label for the name of the device
    @IBOutlet weak var deviceNameLabel: UILabel!
    /// A switch which displays and changes the `isOn` property of the device
    @IBOutlet weak var deviceIsOnSwitch: UISwitch!
    
    /// The table view cells delegate which reports when the mark as read button is tapped
    weak var delegate: DeviceTableViewCellDelegate?
    
    /// Updates the table view cells views for the given devices content
    /// - Parameter device: The device to display in the cell
    func updateViews(device: Device) {
        deviceNameLabel.text = device.name
        deviceIsOnSwitch.isOn = device.isOn
    }

    @IBAction func deviceIsOnSwitchValueChanged(_ sender: UISwitch) {
        delegate?.isOnSwitchToggled(self)
    }
}
