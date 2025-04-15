//
//  LoadingView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//

import SwiftUI
import Lottie  // Подключаем Lottie для анимаций.

struct LottieAnimationViewWrapper: UIViewRepresentable {
    let filename: String  // Имя JSON-файла с анимацией.

    //MARK: - Создаёт и возвращает `UIView`, который будет содержать Lottie-анимацию.
    func makeUIView(context: Context) -> UIView {
        let view = UIView()  // Создаём контейнер для анимации.

        // Создаём объект Lottie-анимации, используя переданное имя файла.
        let animationView = LottieAnimationView(name: filename)
        
        // Настройка размеров анимации.
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFit  // Сохраняем пропорции.

        // Добавляем анимацию в контейнер.
        view.addSubview(animationView)

        // Запускаем анимацию и выводим сообщение, когда она завершится.
        animationView.play { finished in
            if finished {
                print("Анимация завершена")  // Лог для отслеживания завершения анимации.
            }
        }

        return view  // Возвращаем контейнер с анимацией.
    }

    //MARK: - Метод вызывается, если SwiftUI решит обновить это представление.
    func updateUIView(_ uiView: UIView, context: Context) {
        // Этот метод можно использовать для обновления анимации, если потребуется.
    }
}
