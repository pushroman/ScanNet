//
//  LanDevice.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import Foundation
import LanScanner

struct LanDeviceModel: Identifiable {
    let id = UUID()
    let name: String
    let ipAddress: String
    let mac: String
    let brand: String
    

    //MARK: - Инициализатор для Core Data
    init(name: String, ipAddress: String, mac: String, brand: String) {
        self.name = name
        self.ipAddress = ipAddress
        self.mac = mac
        self.brand = brand
    }

    //MARK: - Инициализатор для преобразования из библиотеки `LanDevice`
    init(from device: LanDevice) {
        self.name = device.name
        self.ipAddress = device.ipAddress
        self.mac = device.mac
        self.brand = device.brand
    }
}
