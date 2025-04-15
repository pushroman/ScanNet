//
//  LanViewModel.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI
import LanScanner

class LanScanViewModel: ObservableObject {

    @Published var connectedDevices = [LanDevice]()
    @Published var progress: CGFloat = 0.0
    @Published var title: String = ""
    @Published var showAlert = false

    private lazy var scanner = LanScanner(delegate: self)

    init() {
        startScanning()
    }

    func startScanning() {
        connectedDevices.removeAll()
        progress = 0.0
        scanner.start()
    }
}

extension LanScanViewModel: LanScannerDelegate {
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        DispatchQueue.main.async {
            self.progress = progress
            self.title = address
        }
    }

    func lanScanDidFindNewDevice(_ device: LanDevice) {
        DispatchQueue.main.async {
            self.connectedDevices.append(device)
        }
    }

    func lanScanDidFinishScanning() {
        DispatchQueue.main.async {
            self.showAlert = true
        }
    }
}

extension LanDevice: Identifiable {
    public var id: UUID { UUID() }
}
