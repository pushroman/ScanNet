//
//  LoadingView.swift
//  ScanNet
//
//  Created by Роман Пушкарев on 15.02.2025.
//

import SwiftUI
import Lottie

struct LottieAnimationViewWrapper: UIViewRepresentable {
    let filename: String

    //MARK: - Создаём и возвращаем `UIView`, который будет содержать Lottie-анимацию.
    func makeUIView(context: Context) -> UIView {
        let view = UIView()

      
        let animationView = LottieAnimationView(name: filename)
        
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFit  // Сохраняем пропорции.
        view.addSubview(animationView)

        animationView.play { finished in
            if finished {
                print("Анимация завершена")
            }
        }

        return view  // Возвращаем контейнер с анимацией.
    }

    //MARK: - Метод вызывается, если SwiftUI решит обновить это представление.
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
