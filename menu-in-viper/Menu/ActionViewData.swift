//
//  ActionViewData.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

import UIKit

/// UIAction生成処理をラップ&Testableにするために値を中継する用のViewData
/// - NOTE: desctructive かつ isOn というケースは想定しづらいため、どちらか一方しか指定できない前提でイニシャライザを定義している
struct ActionViewData {
    typealias Handler = (ActionViewData) -> Void
    
    let title: String
    let image: UIImage?
    let isDestructive: Bool
    let isOn: Bool
    let handler: Handler
    
    init(title: String, image: UIImage? = nil, isDestructive: Bool = false, isOn: Bool = false, handler: @escaping Handler) {
        self.title = title
        self.image = image
        self.isDestructive = isDestructive
        self.isOn = isOn
        self.handler = handler
    }
}

// MARK: - Convert into UIAction

extension ActionViewData {
    func toUIAction() -> UIAction {
        let attributes: UIMenuElement.Attributes
        if isDestructive {
            attributes = [.destructive]
        } else {
            attributes = []
        }

        let state: UIMenuElement.State = isOn ? .on : .off

        let actionHandler: UIActionHandler = { _ in
            handler(self)
        }
        
        return UIAction(title: title, image: image, attributes: attributes, state: state, handler: actionHandler)
    }
}
