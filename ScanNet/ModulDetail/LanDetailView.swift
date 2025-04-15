//
//  LanDetailView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 16.02.2025.
//

import SwiftUI
//MARK: - Экран с детальной информацией о LAN-устройстве.
struct DeviceDetailView: View {
    let device: LanDeviceModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Информация об устройстве")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            LanDetailRow(label: "Имя:", value: device.name)
            LanDetailRow(label: "IP-адрес:", value: device.ipAddress)
            LanDetailRow(label: "MAC-адрес:", value: device.mac)
            LanDetailRow(label: "Бренд:", value: device.brand)

            Spacer()
        }
        .padding()
        .navigationTitle("Детали устройства")
    }
}

//MARK: - Вспомогательный компонент, который создаёт строку с названием параметра и его значением.
struct LanDetailRow: View {
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
