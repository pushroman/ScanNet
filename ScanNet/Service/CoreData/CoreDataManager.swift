//
//  CoreDataManager.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//



import CoreData
import CoreBluetooth

//MARK: - Менеджер для работы с Core Data, который управляет сохранением и извлечением данных
class CoreDataManager {
    // Синглтон для доступа к менеджеру Core Data
    static let shared = CoreDataManager()

    // Persistent контейнер для работы с Core Data
    let persistentContainer: NSPersistentContainer

    //MARK: - Инициализация менеджера
    private init() {
        // Создаем persistent контейнер для модели "ScanNetModel"
        persistentContainer = NSPersistentContainer(name: "ScanNetModel")
        
        // Загружаем хранилище и обрабатываем возможные ошибки
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error)")  // Остановка приложения при ошибке
            }
        }
    }
    
    //MARK: - Функция для сохранения нового устройства в Core Data
    func saveDevice(name: String, ipAddress: String? = nil, mac: String? = nil, brand: String? = nil, uuid: String? = nil, rssi: Int16? = nil, status: String? = nil) {
        let context = persistentContainer.viewContext
        
        // Проверяем, существует ли устройство с таким же UUID или IP
        if let uuid = uuid, deviceExists(uuid: uuid) {
            print("Устройство с таким UUID уже существует.")
            return
        }
        if let ip = ipAddress, deviceExists(ip: ip) {
            print("LAN-устройство с таким IP уже существует.")
            return
        }
        
        // Создаем новое устройство и заполняем его данными
        let device = Device(context: context)
        device.name = name
        device.ipAddress = ipAddress
        device.mac = mac
        device.brand = brand
        device.uuid = uuid
        device.rssi = rssi ?? 0
        device.status = status

        // Сохраняем изменения в контексте
        do {
            try context.save()
            print("Устройство сохранено.")
        } catch {
            print("Ошибка сохранения устройства: \(error)")  // Обрабатываем ошибку сохранения
        }
    }

    //MARK: - Проверка существования устройства по UUID
    func deviceExists(uuid: String) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)

        // Пытаемся выполнить запрос и возвращаем результат
        do {
            return try !context.fetch(fetchRequest).isEmpty
        } catch {
            print("Ошибка при проверке существования устройства по UUID: \(error)")
            return false
        }
    }

    //MARK: - Проверка существования устройства по IP-адресу
    func deviceExists(ip: String) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ipAddress == %@", ip)

        // Пытаемся выполнить запрос и возвращаем результат
        do {
            return try !context.fetch(fetchRequest).isEmpty
        } catch {
            print("Ошибка при проверке существования устройства по IP: \(error)")
            return false
        }
    }

    //MARK: - Получение всех устройств (LAN и Bluetooth)
    // Функция для получения всех устройств из Core Data
    func fetchDevices() -> [Device] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Ошибка загрузки данных: \(error)")
            return []
        }
    }
}












//class CoreDataManager {
//    static let shared = CoreDataManager()
//
//    let persistentContainer: NSPersistentContainer
//
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "ScanNetModel")
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Ошибка загрузки Core Data: \(error)")
//            }
//        }
//    }
//
//    func saveDevice(name: String, ipAddress: String, mac: String, brand: String) {
//        let context = persistentContainer.viewContext
//        let device = Device(context: context)
//        device.name = name
//        device.ipAddress = ipAddress
//        device.mac = mac
//        device.brand = brand
//
//        do {
//            try context.save()
//        } catch {
//            print("Ошибка сохранения устройства: \(error)")
//        }
//    }
//
//    func fetchDevices() -> [Device] {
//        let context = persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
//
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Ошибка загрузки данных: \(error)")
//            return []
//        }
//    }
//}
