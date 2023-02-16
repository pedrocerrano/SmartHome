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
        loadDevicesFromDisk()
    } //: INITIALIZER
    
    
    //MARK: - FUNCTIONS
    func toggleIsOn(device: Device) {
        device.isOn.toggle()
        
        saveDevicesToDisk()
    } //: TOGGLE
    
    
    func toggleAllDevicesOn(on: Bool) {
        devices.forEach { $0.isOn = on }
    } //: Toggle ALL ON
    
    
    //MARK: - CRUD
    func createDevice(newName: String) {
        let newDevice = Device(name: newName)
        devices.append(newDevice)
        
        saveDevicesToDisk()
    } //: CREATE
    
    
    func deleteDevice(deviceToDelete: Device) {
        guard let deviceIndex = devices.firstIndex(of: deviceToDelete) else { return }
        devices.remove(at: deviceIndex)
        
        saveDevicesToDisk()
    } //: DELETE
    
    
    //MARK: - PERSISTENCE
    private var devicesURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("devices.json")
        return url
    } //: LOCAL STORAGE LOCATION
    
    
    func saveDevicesToDisk() {
        guard let url = devicesURL else { return }
        do {
            let data = try JSONEncoder().encode(devices)
            try data.write(to: url)
        } catch {
            print("Error Saving Devices", error.localizedDescription)
        } //: DO-CATCH
    } //: SAVE
    
    
    func loadDevicesFromDisk() {
        guard let url = devicesURL else { return }
        do {
            let retreivedData   = try Data(contentsOf: url)
            let decodedDevices  = try JSONDecoder().decode([Device].self, from: retreivedData)
            self.devices        = decodedDevices
        } catch {
            print("Error Loading Devices", error.localizedDescription)
        } //: DO-CATCH
    } //: LOAD
    
} //: CLASS
