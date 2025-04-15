//
//  BluetoothDevice.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import Foundation

//MARK: - Структура для хранения информации о Bluetooth-устройстве
struct BluetoothDevice: Identifiable {
    let id: UUID // Уникальный идентификатор для каждого устройства
    let name: String // Имя устройства
    let uuid: String // UUID устройства, уникальный идентификатор каждого устройства
    let rssi: Int // Уровень сигнала устройства (RSSI)
    let status: String // Статус устройства
}
