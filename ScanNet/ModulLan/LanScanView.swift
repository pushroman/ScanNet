//
//  LanScanView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//


import SwiftUI  

//MARK: - Экран Lan (view)
struct LanScanView: View {
    @StateObject private var viewModel = LanScanViewModel()
    @State private var selectedDevice: LanDeviceModel?
    @State private var isShowingDetail = false

    var body: some View {
        //MARK: - Контейнер, выравнивающий элементы по вертикали и с отступами слева
        VStack(alignment: .leading) {
            
            VStack {
                HStack {
                    Text("Поиск LAN")
                        .font(.title)
                    
                    if viewModel.isScanning {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1)
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    //MARK: - Кнопка для запуска/остановки сканирования
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

            //MARK: - Уведомление, если сканирование завершено
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Сканирование завершено"),
                    message: Text("Найдено устройств: \(viewModel.connectedDevices.count)")
                )
            }

            //MARK: - Список найденных устройств
            List(viewModel.connectedDevices) { device in
                Button {
                    selectedDevice = device
                    isShowingDetail = true
                } label: {
                    VStack(alignment: .leading) {
                        Text(device.name)
                            .font(.headline)
                        Text("IP: \(device.ipAddress)")
                            .font(.subheadline)
                        Text("MAC: \(device.mac)")
                            .font(.subheadline)
                        Text("Brand: \(device.brand)")
                            .font(.subheadline)
                    }
                    .padding()
                }
            }

        }
        .navigationTitle("Сканирование сети")
        .sheet(item: $selectedDevice) { device in
            DeviceDetailView(device: device)
        }
    }
}

#Preview {
    LanScanView()
}
