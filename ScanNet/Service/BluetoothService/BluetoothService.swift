//
//  BluetoothService.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.


import CoreBluetooth
import Combine

//MARK: - Сервис для работы с Bluetooth
class BluetoothService: NSObject, ObservableObject {
    // Свойства, публикующие изменения в UI
    @Published var devices: [BluetoothDevice] = [] // Список найденных устройств
    @Published var showBluetoothAlert = false  // Показывать предупреждение, если Bluetooth не включен
    
    private var centralManager: CBCentralManager!  // Центральный менеджер Bluetooth
    private var scanStartTime: Date?  // Время начала сканирования для дальнейшего использования
    
    override init() {
        super.init()
        // Инициализация центрального менеджера с делегатом
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //MARK: - Начать сканирование устройств Bluetooth
    func startScanning() {
        // Проверяем, включен ли Bluetooth
        if centralManager.state == .poweredOn {
            devices.removeAll()  // Очищаем список найденных устройств перед новым сканированием
            scanStartTime = Date()  // Запоминаем время начала сканирования
            // Запускаем сканирование без фильтрации по сервисам
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        } else {
            // Если Bluetooth выключен, показываем предупреждение
            showBluetoothAlert = true
        }
    }
    
    //MARK: - Остановить сканирование устройств
    func stopScanning() {
        centralManager.stopScan()  // Останавливаем сканирование
    }
}

extension BluetoothService: CBCentralManagerDelegate {
    
    //MARK: - Вызывается при изменении состояния Bluetooth (например, если он выключен или включен)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            print("Bluetooth не включен")
            showBluetoothAlert = true  // Показываем предупреждение, если Bluetooth выключен
        }
    }
    
    //MARK: - Метод вызывается при обнаружении устройства Bluetooth
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        // Создаем объект BluetoothDevice с данными о найденном устройстве
        let newDevice = BluetoothDevice(
            id: UUID(),  // Генерируем уникальный идентификатор для устройства
            name: peripheral.name ?? "Неизвестное устройство",  // Имя устройства (или "Неизвестное устройство" если имя не найдено)
            uuid: peripheral.identifier.uuidString,  // UUID устройства
            rssi: RSSI.intValue,  // Уровень сигнала устройства
            status: "Не подключено"  // Статус устройства
        )
        
        //MARK: - Обновляем список найденных устройств и сохраняем устройство в CoreData
        DispatchQueue.main.async {
            self.devices.append(newDevice)
            
            // Сохраняем найденное устройство в Core Data
            CoreDataManager.shared.saveDevice(
                name: newDevice.name,
                uuid: newDevice.uuid,
                rssi: Int16(newDevice.rssi),
                status: newDevice.status
            )
        }
    }
}
