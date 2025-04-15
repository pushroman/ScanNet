//
//  LanViewModel.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI
import LanScanner  

//MARK: - ViewModel для управления сканированием устройств в сети LAN
class LanScanViewModel: ObservableObject {
    @Published var connectedDevices = [LanDeviceModel]()
    @Published var showAlert = false
    @Published var isScanning = false

    private lazy var scanner = LanScanner(delegate: self)
    private var timer: Timer?

    //MARK: - Метод для начала сканирования
    func startScanning() {
        connectedDevices.removeAll() 
        isScanning = true
        showAlert = false
        scanner.start()

        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { _ in
            self.stopScanning()
        }
    }

    //MARK: - Метод для остановки сканирования
    func stopScanning() {
        isScanning = false
        scanner.stop()
        timer?.invalidate()
        showAlert = true  
    }
}

// Расширение для соответствия делегату LanScannerDelegate
extension LanScanViewModel: LanScannerDelegate {
    //MARK: - Метод для обновления прогресса сканирования (можно использовать для отображения прогресса)
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        // В этом примере мы не используем прогресс, но можно добавить логику
    }

    //MARK: - Метод, вызываемый при нахождении нового устройства в сети
    func lanScanDidFindNewDevice(_ device: LanDevice) {
        // Обновляем список устройств на главном потоке
        DispatchQueue.main.async {
            let newDevice = LanDeviceModel(from: device)  // Преобразуем найденное устройство в модель
            self.connectedDevices.append(newDevice)  // Добавляем устройство в список
            // Сохраняем информацию о новом устройстве в Core Data
            CoreDataManager.shared.saveDevice(
                name: newDevice.name,
                ipAddress: newDevice.ipAddress,
                mac: newDevice.mac,
                brand: newDevice.brand
            )
        }
    }

    //MARK: - Метод, вызываемый по завершению сканирования
    func lanScanDidFinishScanning() {
        self.stopScanning()  // Останавливаем сканирование
    }
}
