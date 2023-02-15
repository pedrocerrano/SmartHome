//
//  DeviceController.swift
//  SmartHome
//
//  Created by iMac Pro on 2/15/23.
//

import Foundation

class DeviceController {
    
    //MARK: - PROPERTIES
    static let sharedIntstance = DeviceController()
    var devices: [Device] = []
    
    
    init() {
        loadDevices()
    } //: INITIALIZER
    
    
    //MARK: - FUNCTIONS
    func toggleIsOn(device: Device) {
        device.isOn.toggle()
        
        saveDevices()
    } //: TOGGLE
    
    
    //MARK: - CRUD
    func createDevice(newName: String) {
        let newDevice = Device(name: newName)
        devices.append(newDevice)
        
        saveDevices()
    } //: CREATE
    
    
    func deleteDevice(deviceToDelete: Device) {
        
        saveDevices()
    } //: DELETE
    
    
    //MARK: - PERSISTENCE
    private var url: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let finalURL = documentsDirectory.appendingPathComponent("devices.json")
        return finalURL
    } //: LOCAL STORAGE LOCATION
    
    
    func saveDevices() {
        guard let url = url else { return }
        do {
            let data = try JSONEncoder().encode(devices)
            try data.write(to: url)
        } catch {
            print("Error Saving Devices", error.localizedDescription)
        } //: DO-CATCH
    } //: SAVE
    
    
    func loadDevices() {
        guard let url = url else { return }
        do {
            let retreivedData = try Data(contentsOf: url)
            let decodedData   = try JSONDecoder().decode([Device].self, from: retreivedData)
            self.devices      = decodedData
        } catch {
            print("Error Loading Devices", error.localizedDescription)
        } //: DO-CATCH
    } //: LOAD
    
} //: CLASS
