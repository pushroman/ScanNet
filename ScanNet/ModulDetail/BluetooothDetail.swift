//
//  BluetooothDetail.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 16.02.2025.
//

import SwiftUI

import SwiftUI

//MARK: - Экран, который показывает информацию о выбранном Bluetooth-устройс.
struct BluetoothDeviceDetailView: View {
    let device: BluetoothDevice
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
           
            Text("Информация об устройстве")
                .font(.title)
                .bold()
                .padding(.bottom, 10)

        
            BluetoothDetailRow(label: "Имя:", value: device.name)
            BluetoothDetailRow(label: "UUID:", value: device.uuid)
            BluetoothDetailRow(label: "RSSI:", value: "\(device.rssi)")
            BluetoothDetailRow(label: "Статус:", value: device.status)

            Spacer()
        }
        .padding()
        .navigationTitle("Детали устройства")
    }
}

//MARK: - Компонент, который создаёт строку с названием параметр его значением.
struct BluetoothDetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
