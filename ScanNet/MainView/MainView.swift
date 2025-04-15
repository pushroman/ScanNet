//
//  MainView.swift
//
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI

//MARK: - Основной экран приложения
struct MainView: View {
    // Состояние для отслеживания
    @State private var isLaunched = false

    var body: some View {
        ZStack {
            // Если экран был запущен, показываем основной экран
            if isLaunched {
                TabView {
                    // Экран Bluetooth с иконкой
                    BluetoothView()
                        .tabItem {
                            Label("Bluetooth", systemImage: "antenna.radiowaves.left.and.right")
                        }
                    
                    LanScanView()
                        .tabItem {
                            Label("Lan", systemImage: "wifi")
                        }

                    HistoryView()
                        .tabItem {
                            Label("История", systemImage: "clock")
                        }
                }
            } else {
                
                VStack {
                    LottieAnimationViewWrapper(filename: "Loading")  // Вставляем анимацию Lottie
                        .frame(width: 200, height: 200)  // Размер анимации
                        .padding(.top, 20)  // Отступ сверху
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)  // Белый фон
                .edgesIgnoringSafeArea(.all)  // Игнорируем безопасные зоны (например, выемки экрана)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isLaunched = true
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Превью для предварительного просмотра в Xcode
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//MARK: - Главная точка входа в приложение
@main
struct ScanNetApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
