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
    // Массив устройств, обновляется при каждом изменении
    @Published var devices: [BluetoothDevice] = [] {
        didSet {
            saveDevicesToCoreData()  // Сохраняем новые устройства в CoreData при обновлении
        }
    }
    
    // Флаг, показывающий, нужно ли отображать алерт
    @Published var showAlert = false
    
    // Сервис для работы с Bluetooth
    private var bluetoothService = BluetoothService()
    
    // Хранилище для подписок Combine
    private var cancellables = Set<AnyCancellable>()
    
    // Таймер для автоматической остановки сканирования
    private var timer: Timer?
    
    // Флаг, показывающий, идет ли сканирование
    @Published var isScanning = false
    
    //MARK: - Инициализация ViewModel
    init() {
        // Подписываемся на изменения списка устройств от Bluetooth-сервиса
        bluetoothService.$devices
            .assign(to: \.devices, on: self)  // Обновляем массив устройств в ViewModel
            .store(in: &cancellables)  // Сохраняем подписку в cancellables
    }
    
    //MARK: - Метод для начала сканирования
    func startScanning() {
        devices.removeAll()  // Очищаем список устройств перед началом нового сканирования
        isScanning = true  // Включаем индикатор сканирования
        showAlert = false  // Скрываем алерт, если сканирование только началось
        bluetoothService.startScanning()  // Запускаем сканирование через Bluetooth-сервис
        
        // таймер для завершения сканирования через 15 сек
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            self.stopScanning()  // Остановить сканирование после 15 сек
        }
    }
    
    //MARK: - Метод для остановки сканирования
    func stopScanning() {
        isScanning = false  // Останавливаем индикатор сканирования
        bluetoothService.stopScanning()  // Останавливаем сканирование через Bluetooth-сервис
        timer?.invalidate()  // Останавливаем таймер
        showAlert = true  // Показываем алерт по завершению сканирования
    }
    
    //MARK: - Метод для сохранения устройств в Core Data
    private func saveDevicesToCoreData() {
        for device in devices {  // Проходим по каждому устройству
            CoreDataManager.shared.saveDevice(  // Сохраняем информацию о каждом устройстве
                name: device.name,
                uuid: device.uuid,
                rssi: Int16(device.rssi),
                status: device.status
            )
        }
    }
}
