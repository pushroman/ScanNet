//
//  HistoryView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//

import SwiftUI

//MARK: - Экран, который показывает историю сканирования
struct HistoryView: View {
    @StateObject var viewModel = DeviceHistoryViewModel()
    @State private var showingBluetooth = false
    @State private var selectedDevice: Device?

    var body: some View {
        NavigationView {
            VStack {
                Text("История устройств")
                    .font(.title)
                    .padding(.bottom, 2)

                VStack(spacing: 4) {
                    HStack {
                        Button("LAN") {
                            showingBluetooth = false
                        }
                        .padding(10)
                        .background(showingBluetooth ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        
                        Button("Bluetooth") {
                            showingBluetooth = true
                        }
                        .padding(10)
                        .background(showingBluetooth ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                }
                .padding()

                
                List(showingBluetooth ? viewModel.bluetoothDevices : viewModel.lanDevices, id: \.self) { device in
                    Button {
                        selectedDevice = device
                    } label: {
                        VStack(alignment: .leading) {
                            Text(device.name ?? "Неизвестное устройство")
                                .font(.headline)

        
                            if showingBluetooth {
                                Text("UUID: \(device.uuid ?? "—")")
                                    .font(.subheadline)
                                Text("RSSI: \(device.rssi ?? 0)")
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
                }
                .onAppear {
                    viewModel.fetchDevices()  // Загрузка данных при появлении экрана
                }
            }
            .sheet(item: $selectedDevice) { device in
               
                if !showingBluetooth {
                    let lanDevice = LanDeviceModel(
                        name: device.name ?? "Неизвестное устройство",
                        ipAddress: device.ipAddress ?? "",
                        mac: device.mac ?? "",
                        brand: device.brand ?? ""
                    )
                    DeviceDetailView(device: lanDevice)
                } else {
                    BluetoothDeviceDetailView(device: BluetoothDevice(
                        id: UUID(),
                        name: device.name ?? "Неизвестное устройство",
                        uuid: device.uuid ?? "—",
                        rssi: Int(device.rssi ?? 0),
                        status: device.status ?? "—"
                    ))
                }
            }
        }
    }
}
