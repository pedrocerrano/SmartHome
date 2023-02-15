//
//  DeviceListTableViewController.swift
//  SmartHome
//
//  Created by iMac Pro on 2/15/23.
//

import UIKit

class DeviceListTableViewController: UITableViewController {

    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    } //: DidLOAD
    
    
    //MARK: - ACTIONS
    @IBAction func addDeviceButtonTapped(_ sender: Any) {
        presentNewDeviceAlertController()
    } //: ADD TAPPED

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DeviceController.sharedIntstance.devices.count
    } //: # ROWS


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "smartHomeCell", for: indexPath) as? DeviceTableViewCell else { return UITableViewCell() }

        let deviceIndex = DeviceController.sharedIntstance.devices[indexPath.row]
        cell.updateViews(device: deviceIndex)
        cell.delegate = self

        return cell
    } //: CELL CONFIG


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } //: DELETE
    } //: EDITING STYLE

    
    //MARK: - FUNCTIONS
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "New Device", message: "Enter the name of your device below", preferredStyle: .alert)
        
        alertController.addTextField { alertTextField in
            alertTextField.placeholder = "New Device Name..."
        } //: PLACEHOLDER
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(dismissAction)
        
        let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                  let newDevice = contentTextField.text, !newDevice.isEmpty else { return }
            DeviceController.sharedIntstance.createDevice(newName: newDevice)
            self.tableView.reloadData()
        } //: TEXT CONFIG
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true)
    } //: ALERT
    
} //: CLASS


extension DeviceListTableViewController: DeviceTableViewCellDelegate {
    func isOnSwitchToggled(cell: DeviceTableViewCell) {
        guard let cellIndex = tableView.indexPath(for: cell) else { return }
        let device = DeviceController.sharedIntstance.devices[cellIndex.row]
        DeviceController.sharedIntstance.toggleIsOn(device: device)
        cell.updateViews(device: device)
    } //: IMPLEMENTATION
} //: EXTENSTION
