//
//  LanScanView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI

struct LanScanView: View {
    @StateObject var viewModel = LanScanViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text(viewModel.title)
                        .font(.title)
                    Spacer()
                    Button {
                        viewModel.startScanning()
                    } label: {
                        Image(systemName: "repeat")
                            .foregroundColor(.black)
                    }
                }
                ProgressView(value: viewModel.progress)
            }
            .padding()

            List(viewModel.connectedDevices) { device in
                VStack(alignment: .leading) {
                    Text(device.name)
                        .font(.body)
                    Text(device.mac)
                        .font(.caption)
                    Text(device.brand)
                        .font(.footnote)
                }
                .onTapGesture {
                    #if os(iOS)
                    UIPasteboard.general.string = device.name
                    #endif
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Сканирование завершено"),
                    message: Text("Найдено устройств: \(viewModel.connectedDevices.count)")
                )
            }
        }
    }
}
