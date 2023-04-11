//
//  Presenter.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

protocol View: AnyObject {
    func inject(_ presenter: Presentation)
}

protocol Presentation {
    func viewDidLoad()
}

final class Presenter: Presentation {
    private weak var view: View?
    private let wireframe: Wireframe

    init(view: View,
         wireframe: Wireframe) {
        self.view = view
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        print("hello world")
        // Do something
    }
}
