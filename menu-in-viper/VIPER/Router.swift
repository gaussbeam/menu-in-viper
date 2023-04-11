//
//  Router.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

import UIKit

protocol Wireframe {
    func showActionSheet(handler: @escaping (String) -> Void)
}

struct Router: Wireframe {
    private weak var viewController: UIViewController?
    
    private init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules() -> UIViewController {
        let vc = ViewController.instantiate()
        
        let router = Router(viewController: vc)
        let presenter = Presenter(
            view: vc,
            wireframe: router
        )
        
        vc.inject(presenter)
        
        return vc
    }
    
    func showActionSheet(handler: @escaping (String) -> Void) {
        let actionSheet = UIAlertController(title: "ActionSheet Sample", message: nil, preferredStyle: .actionSheet)
        let actionHandler: (UIAlertAction) -> Void = { action in
            handler("\(action.title!) in actionsheet tapped")
        }
        
        actionSheet.addAction(UIAlertAction(title: "destructive action", style: .destructive, handler: actionHandler))
        actionSheet.addAction(UIAlertAction(title: "default action", style: .default, handler: actionHandler))
        
        viewController?.present(actionSheet, animated: true)
    }
}
