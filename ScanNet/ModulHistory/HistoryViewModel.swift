//
//  ViewModel.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//

import Combine

class DeviceHistoryViewModel: ObservableObject {
    @Published var lanDevices: [Device] = []
    @Published var bluetoothDevices: [Device] = []

    init() {
        fetchDevices()
    }

    func fetchDevices() {
        let allDevices = CoreDataManager.shared.fetchDevices()

        lanDevices = allDevices.filter { $0.ipAddress != nil }
        bluetoothDevices = allDevices.filter { $0.uuid != nil }
    }
}
