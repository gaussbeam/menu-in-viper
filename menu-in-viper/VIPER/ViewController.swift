//
//  ViewController.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/07.
//

import UIKit

final class ViewController: UIViewController {
    private var presenter: Presentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: View

extension ViewController: View {
    func inject(_ presenter: Presentation) {
        self.presenter = presenter
    }
}

// MARK: - Init with storyboard

extension ViewController {
    static func instantiate() -> ViewController {
        UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! ViewController
    }
}
