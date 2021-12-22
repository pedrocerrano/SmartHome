//
//  DevicesTableViewController.swift
//  SmartHome
//
//  Created git by Trevor Adcock on 12/21/21.
//

import UIKit

class DevicesTableViewController: UITableViewController {
    
    var fileName: String?
    var deviceController: DeviceController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deviceController = DeviceController(fileName: fileName ?? "defaultRoom.json")
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOn), name: TurnAllOnNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOff), name: TurnAllOffNotificationName, object: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceController.devices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as? DeviceTableViewCell else { return UITableViewCell() }
        let device = deviceController.devices[indexPath.row]
        cell.updateViews(device: device)
        cell.delegate = self
        return cell
    }
    
    /// Presents the create new device alert controller
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "New Device", message: "Enter the name of your device below", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Device Name"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                    let name = contentTextField.text  else { return }
            self.deviceController.createDevice(name: name)
            self.tableView.reloadData()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    @objc func turnAllDevicesOn() {
        deviceController.toggleAllDevices(on: true)
        tableView.reloadData()
    }
    
    @objc func turnAllDevicesOff() {
        deviceController.toggleAllDevices(on: false)
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentNewDeviceAlertController()
    }
}

// MARK: - deviceTableViewCellDelegate Conformance
extension DevicesTableViewController: DeviceTableViewCellDelegate {
    
    func isOnSwitchToggled(_ cell: DeviceTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let device = deviceController.devices[indexPath.row]
        deviceController.toggleIsOn(device: device)
        cell.updateViews(device: device)
    }
}
