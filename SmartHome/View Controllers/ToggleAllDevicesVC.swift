//
//  ToggleAllDevicesVC.swift
//  SmartHome
//
//  Created by iMac Pro on 2/16/23.
//

import UIKit

class ToggleAllDevicesVC: UIViewController {

    //MARK: - ACTIONS
    
    @IBAction func turnAllOnButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Constants.Notifications.turnOnAllNotificationName, object: nil)
    } //: ALL ON TAPPED
    
    
    
    @IBAction func turnAllOffButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Constants.Notifications.turnOffAllNotificationName, object: nil)
    } //: ALL OFF TAPPED
    
} //: CLASS
