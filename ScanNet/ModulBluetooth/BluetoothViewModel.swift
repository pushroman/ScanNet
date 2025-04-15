//
//  BluetoothViewModel.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI
import Combine
import CoreData

//MARK: - ViewModel для управления Bluetooth-устройствами
class BluetoothViewModel: ObservableObject {
    @Published var devices: [BluetoothDevice] = [] {
        didSet {
            saveDevicesToCoreData()
        }
    }
    @Published var showAlert = false
    
    private var bluetoothService = BluetoothService()
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    @Published var isScanning = false
    
    //MARK: - Инициализация ViewModel
    init() {
        bluetoothService.$devices
            .assign(to: \.devices, on: self)
            .store(in: &cancellables)
    }
    
    //MARK: - Метод для начала сканирования
    func startScanning() {
        devices.removeAll()
        isScanning = true
        showAlert = false
        bluetoothService.startScanning()
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            self.stopScanning()  
        }
    }
    
    //MARK: - Метод для остановки сканирования
    func stopScanning() {
        isScanning = false
        bluetoothService.stopScanning()
        timer?.invalidate()
        showAlert = true
    }
    
    //MARK: - Метод для сохранения устройств в Core Data
    private func saveDevicesToCoreData() {
        for device in devices {
            CoreDataManager.shared.saveDevice(  
                name: device.name,
                uuid: device.uuid,
                rssi: Int16(device.rssi),
                status: device.status
            )
        }
    }
}
