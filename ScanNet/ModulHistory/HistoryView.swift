//
//  HistoryView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//

import SwiftUI

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    @State private var showingBluetooth = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("LAN") {
                        showingBluetooth = false
                    }
                    .padding()
                    .background(showingBluetooth ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Bluetooth") {
                        showingBluetooth = true
                    }
                    .padding()
                    .background(showingBluetooth ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()

                List(showingBluetooth ? viewModel.bluetoothDevices : viewModel.lanDevices) { device in
                    VStack(alignment: .leading) {
                        Text(device.name ?? "Неизвестное устройство")
                            .font(.headline)

                        if showingBluetooth {
                            Text("UUID: \(device.uuid ?? "—")")
                                .font(.subheadline)
                            Text("RSSI: \(device.rssi)")
                                .font(.subheadline)
                            Text("Статус: \(device.status ?? "—")")
                                .font(.subheadline)
                        } else {
                            Text("IP: \(device.ipAddress ?? "—")")
                                .font(.subheadline)
                            Text("MAC: \(device.mac ?? "—")")
                                .font(.subheadline)
                            Text("Бренд: \(device.brand ?? "—")")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
                .navigationTitle("История устройств")
            }
        }
    }
}

#Preview {
    DeviceHistoryView()
}
