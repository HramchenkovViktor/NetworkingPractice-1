//
//  ViewController.swift
//  NetworkingPractice#1
//
//  Created by Виктор on 03.11.2026.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        Task {
            await loadTodo()
        }
    }

    private func loadTodo() async {

        guard let url = URL(
            string: "https://jsonplaceholder.typicode.com/todos/1"
        ) else {
            print("Неверный URL")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Ответ не является HTTP-ответом")
                return
            }

            print("HTTP-статус: \(httpResponse.statusCode)")

            guard (200...299).contains(httpResponse.statusCode) else {
                print("Сервер вернул ошибку")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }

        } catch {
            print("Ошибка сети: \(error)")
        }
    }
}

