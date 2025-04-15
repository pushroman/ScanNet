//
//  ScanNet+CoreDataProperties.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//
//


import Foundation
import CoreData  

// Расширение для модели Device, добавляющее функциональность для работы с CoreData
extension Device {
    
    //MARK: - Метод для создания запроса на выборку объектов Device из CoreData
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "ScanNet")  // Возвращаем запрос для сущности "ScanNet"
    }

    //MARK: - LAN
    @NSManaged public var name: String?  // Имя устройства
    @NSManaged public var ipAddress: String?  // IP-адрес устройства для LAN
    @NSManaged public var mac: String?  // MAC-адрес устройства
    @NSManaged public var brand: String?  // Бренд устройства
    //MARK: - Bluetooth
    @NSManaged public var uuid: String?  // UUID устройства для Bluetooth (новый атрибут)
    @NSManaged public var rssi: Int16  // Уровень сигнала (RSSI) для Bluetooth (новый атрибут)
    @NSManaged public var status: String?  // Статус устройства Bluetooth (новый атрибут)
}

// Расширение для протокола Identifiable, которое позволяет использовать экземпляры Device в списках с уникальными идентификаторами
extension Device: Identifiable {}

