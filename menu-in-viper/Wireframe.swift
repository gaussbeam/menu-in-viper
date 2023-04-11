//
//  Wireframe.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

import UIKit

protocol Wireframe {
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
}
