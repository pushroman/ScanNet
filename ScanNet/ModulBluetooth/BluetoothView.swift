//
//  BluetoothView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI

//MARK: - Экран Bluetooth (view)
struct BluetoothView: View {
    
    @StateObject private var viewModel = BluetoothViewModel()
    @State private var selectedDevice: BluetoothDevice?
    @StateObject private var bluetoothService = BluetoothService()

    var body: some View {
        //MARK: - Контейнер, выравнивающий элементы по вертикали и с отступами слева
        VStack(alignment: .leading) {
            
            
            VStack {
                HStack {
                    Text("Поиск Bluetooth")
                        .font(.title)
                    
                    if viewModel.isScanning {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1)
                            .frame(width: 20, height: 20)
                    }
                    
                    // Пробел для отступа
                    Spacer()
                    
                    //MARK: -  Кнопка для запуска/остановки сканирования
                    Button {
                        viewModel.startScanning()
                    } label: {
                       
                        Image(systemName: viewModel.isScanning ? "stop.circle.fill" : "play.circle.fill")
                            .foregroundColor(viewModel.isScanning ? .blue : .gray)
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                    }
                    .disabled(viewModel.isScanning)
                }
            }
            .padding()

            //MARK: -  Уведомление, если Bluetooth выключен
            .alert(isPresented: $bluetoothService.showBluetoothAlert) {
                Alert(title: Text("Bluetooth отключен"))
            }

            //MARK: -  Список найденных устройств
            List(viewModel.devices) { device in
              
                Button {
                    selectedDevice = device
                } label: {
                    
                    VStack(alignment: .leading) {
                        Text(device.name)
                            .font(.headline)
                        Text("UUID: \(device.uuid)")
                            .font(.subheadline)
                        Text("RSSI: \(device.rssi)")
                            .font(.subheadline)
                        Text("Статус: \(device.status)")
                            .font(.subheadline)
                    }
                    .padding()
                }
            }

            //MARK: - Уведомление о завершении сканирования
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Сканирование завершено"),
                    message: Text("Найдено устройств: \(viewModel.devices.count)")
                )
            }
            
        }
        .navigationTitle("Bluetooth Сканирование")
        .sheet(item: $selectedDevice) { device in
            BluetoothDeviceDetailView(device: device)
        }
    }
}






