//
//  BluetoothModel.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import Foundation

//MARK: - Структура для хранения информации о Bluetooth-устройстве
struct BluetoothDevice: Identifiable {
    let id: UUID 
    let name: String
    let uuid: String
    let rssi: Int
    let status: String
}
