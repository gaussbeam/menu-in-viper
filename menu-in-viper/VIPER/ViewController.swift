//
//  ViewController.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/07.
//

import UIKit

final class ViewController: UIViewController {
    private var presenter: Presentation!

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var showMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMenuButton.menu = presenter.buttonMenu.toUIMenu()
        showMenuButton.showsMenuAsPrimaryAction = true
        presenter.viewDidLoad()
    }
}

// MARK: View

extension ViewController: View {
    func inject(_ presenter: Presentation) {
        self.presenter = presenter
    }
    
    func viewDataDidUpdate() {
        self.textLabel.text = presenter.labelString
    }
}

// MARK: - Init with storyboard

extension ViewController {
    static func instantiate() -> ViewController {
        UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! ViewController
    }
}
