//
//  File.swift
//  NetworkingPractice#1
//
//  Created by Виктор on 03.11.2026.
//

import UIKit




class File: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        Task {
            await loadSecondTodo()
        }
    }
    
    private func loadSecondTodo() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/2") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Ответ не является HTTP")
                return
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                print("Ошибка HTTP: \(httpResponse.statusCode)")
                
                return
                
            }
            print("HTTP-статус: \(httpResponse.statusCode)")
            print("Получено байтов: \(data.count)")
        } catch {
            print (error)
            
            
        }
    }
}
