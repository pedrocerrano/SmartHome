//
//  ToggleAllViewController.swift
//  SmartHome
//
//  Created by Trevor Adcock on 12/21/21.
//

import UIKit

let TurnAllOnNotificationName = Notification.Name(rawValue: "TurnOnAllDevicesNotification")

let TurnAllOffNotificationName = Notification.Name(rawValue: "TurnOffAllDevicesNotification")

class ToggleAllViewController: UIViewController {

    @IBAction func turnAllOnButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: TurnAllOnNotificationName, object: nil)
    }
    
    @IBAction func turnAllOffButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: TurnAllOffNotificationName, object: nil)
    }
}
