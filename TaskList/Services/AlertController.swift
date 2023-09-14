//
//  AlertController.swift
//  TaskList
//
//  Created by Динара Шарафутдинова on 14.09.2023.
//

import UIKit

enum UserAction {
    case newTask
    case editTask
    
    var title: String {
        switch self {
        case .newTask:
            return "New Task"
        case .editTask:
            return "Update Task"
        }
    }
}

protocol AlertProtocol {
    func createAlert(completion: @escaping (String) -> Void) -> UIAlertController
}

final class AlertController: AlertProtocol {
    let userAction: UserAction
    let taskTitle: String?
    
    init(userAction: UserAction, taskTitle: String?) {
        self.userAction = userAction
        self.taskTitle = taskTitle
    }
    
    func createAlert(completion: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: userAction.title,
            message: "What do you want to do?",
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: "Save Task", style: .default) { _ in
            guard let task = alertController.textFields?.first?.text else { return }
            guard !task.isEmpty else { return }
            completion(task)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Task"
            textField.text = self?.taskTitle
        }
        
        return alertController
    }
}
