//
//  BluetoothView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 14.02.2025.
//

import SwiftUI

//MARK: - Экран Bluetooth (view)
struct BluetoothView: View {
    // Создаем и инициализируем ViewModel для управления состоянием приложения
    @StateObject private var viewModel = BluetoothViewModel()
    
    // Переменная для хранения выбранного устройства
    @State private var selectedDevice: BluetoothDevice?
    
    // Создаем объект bluetoothService для работы с Bluetooth
    @StateObject private var bluetoothService = BluetoothService()

    var body: some View {
        //MARK: - Контейнер, выравнивающий элементы по вертикали и с отступами слева
        VStack(alignment: .leading) {
            
            // Обертка для горизонтальных элементов
            VStack {
                // Горизонтальное выравнивание элементов
                HStack {
                    // Заголовок для секции "Поиск Bluetooth"
                    Text("Поиск Bluetooth")
                        .font(.title)  // Устанавливаем стиль шрифта для заголовка
                    
                    //Если сканирование активно, показываем индикатор
                    if viewModel.isScanning {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())  // Круглый индикатор загрузки
                            .scaleEffect(1)  // Масштаб индикатора
                            .frame(width: 20, height: 20)  // Устанавливаем фиксированный размер
                    }
                    
                    // Пробел для отступа
                    Spacer()
                    
                    //MARK: -  Кнопка для запуска/остановки сканирования
                    Button {
                        viewModel.startScanning()  // Запуск/остановка сканирования при нажатии
                    } label: {
                        // Изображение кноки, меняющееся в зависимости от состояния сканирования
                        Image(systemName: viewModel.isScanning ? "stop.circle.fill" : "play.circle.fill")
                            .foregroundColor(viewModel.isScanning ? .blue : .gray)  // Цвет кнопки зависит от состояния
                            .imageScale(.large)  // Увеличиваем размер изображения
                            .frame(width: 50, height: 50)  // Устанавливаем размер кнопки
                    }
                    .disabled(viewModel.isScanning)  // Отключаем кнопку, если сканирование идет
                }
            }
            .padding()  // Добавляем отступы вокруг внутреннего VStack

            //MARK: -  Уведомление, если Bluetooth выключен
            .alert(isPresented: $bluetoothService.showBluetoothAlert) {
                Alert(title: Text("Bluetooth отключен"))  // Отображаем уведомление
            }

            //MARK: -  Список найденных устройств
            List(viewModel.devices) { device in
                //  Каждый элемент в списке - это кнопка
                Button {
                    selectedDevice = device  // Сохраняем выбранное устройство
                } label: {
                    // Отображаем данные о каждом устройстве
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
                    .padding()  // Добавляем отступы вокруг информации об устройстве
                }
            }

            //MARK: - Уведомление о завершении сканирования
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Сканирование завершено"),
                    message: Text("Найдено устройств: \(viewModel.devices.count)")  // Сообщаем количество найденных устройств
                )
            }
            
        }
        .navigationTitle("Bluetooth Сканирование")  // Заголовок навигационной панели
        .sheet(item: $selectedDevice) { device in
            // Показываем экран с деталями выбранного устройства
            BluetoothDeviceDetailView(device: device)
        }
    }
}






