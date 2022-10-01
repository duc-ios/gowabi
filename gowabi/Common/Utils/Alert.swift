//
//  Alert.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import UIKit
import Then
import Action

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let action: CocoaAction
}

class Alert {
    static func show(title: String?, message: String?, actionTitle: String? = nil, actions: [AlertAction] = []) {
        keyWindow?.rootViewController?.present(
            UIAlertController(title: title, message: message, preferredStyle: .alert).then { alert in
                if actions.isEmpty {
                    alert.addAction(.init(title: actionTitle ?? "OK", style: .cancel))
                } else {
                    actions.forEach { action in
                        alert.addAction(.init(title: action.title, style: action.style)
                            .with { $0.rx.action = action.action })
                    }
                }
            },
            animated: true)
    }
    
    static func showError(_ error: Error) {
        show(title: "Error", message: error.localizedDescription)
    }
    
    static func showSuccess(_ message: String) {
        show(title: "Success", message: message)
    }
}
