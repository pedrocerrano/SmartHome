//
//  DeviceController.swift
//  SmartHome
//
//  Created by Trevor Adcock on 12/21/21.
//

import Foundation

/// A simple model controller to control the creation, reading and persistence of `Device` instances
class DeviceController {
    
    /// A shared instance of the device controller
    static let shared = DeviceController()
    
    init() {
        loadDevices()
    }
    
    /// The array of Devices and sourece of truth for the app
    private(set) var devices: [Device] = []
    
    /// The URL that Devices are persist to on disk
    private var devicesURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("devices.json")
        return url
    }
    
    /// Creates a new device, adds it to our array of Devices (source of truth) and persists the device to the local disk
    /// - Parameter name: The content of the device
    func createDevice(name: String) {
        let newdevice = Device(text: name)
        devices.append(newdevice)
        saveDevices()
    }
    
    func toggleIsOn(device: Device) {
        device.isOn.toggle()
        DeviceController.shared.saveDevices()
    }
    
    /// Persists the device controllers array of Devices to disk
    func saveDevices() {
        // 1. Get the address to save a file to
        guard let devicesURL = devicesURL else { return }
        do {
            // 2. Convert the swift class into JSON data
            let data = try JSONEncoder().encode(devices)
            // 3. Save the data to the URL from step 1
            try data.write(to: devicesURL)
        } catch {
            print("Error Saving Devices", error)
        }
    }
    
    /// Loads  devices that are persist to the local disk and updates the model controllers `devices` property
    func loadDevices() {
        // 1. Get the address to save a file to
        guard let devicesURL = devicesURL else { return }
        do {
            // 2. Load the raw data from the url
            let data = try Data(contentsOf: devicesURL)
            // 3. Convert the raw data into our Swift class
            let devices = try JSONDecoder().decode([Device].self, from: data)
            self.devices = devices
        } catch {
            print("Error Loading Devices", error)
        }
    }
}
