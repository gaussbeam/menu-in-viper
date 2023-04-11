//
//  MenuViewData.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

import UIKit

/// UIMenu生成処理をラップ&Testableにするために値を中継する用のViewData
struct MenuViewData {
    let title: String
    let actionViewDataList: [ActionViewData]

    init?(_ actionViewDataList: [ActionViewData], title: String = "") {
        guard !actionViewDataList.isEmpty else { return nil }
        
        self.actionViewDataList = actionViewDataList
        self.title = title
    }
}

// MARK: - Convert into UIMenu

extension MenuViewData {
    func toUIMenu() -> UIMenu {
        let actions = actionViewDataList.map { $0.toUIAction() }
        return UIMenu(title: title, options: [], children: actions)
    }
}
