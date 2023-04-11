//
//  Presenter.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

protocol View: AnyObject {
    func inject(_ presenter: Presentation)
    func viewDataDidUpdate()
}

protocol Presentation {
    func viewDidLoad()
    var labelString: String { get }
    var buttonMenu: MenuViewData { get }
}

final class Presenter: Presentation {
    private weak var view: View?
    private let wireframe: Wireframe

    private(set) var labelString: String = ""
    
    init(view: View,
         wireframe: Wireframe) {
        self.view = view
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        updateLabel(string: "hello world")
    }
    
    var buttonMenu: MenuViewData {
        let handler: ActionViewData.Handler = { [weak self] action in
            let string = "\(action.title) tapped"
            self?.updateLabel(string: string)
        }
        
        let defaultAction = ActionViewData(title: "default action", handler: handler)
        let destructiveAction = ActionViewData(title: "destructive action", isDestructive: true, handler: handler)
            
        let actions = [defaultAction, destructiveAction]

        return MenuViewData(actions, title: "Menu sample")!
    }
    
    private func updateLabel(string: String) {
        labelString = string
        view?.viewDataDidUpdate()
    }
}
