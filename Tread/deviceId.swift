//
//  deviceId.swift
//  Tread
//
//  Created by Jorde Guevara on 3/27/25.
//

import Foundation

class DeviceIDManager {
    private static let deviceIDKey = "tread_device_id"
    
    static func getDeviceID() -> String {
        // Check if we already have a device ID stored
        if let existingID = UserDefaults.standard.string(forKey: deviceIDKey) {
            return existingID
        }
        
        // Generate a new device ID
        let newDeviceID = "device-" + UUID().uuidString
        
        // Store it for future use
        UserDefaults.standard.set(newDeviceID, forKey: deviceIDKey)
        
        return newDeviceID
    }
}
