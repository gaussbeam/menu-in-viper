//
//  Presenter.swift
//  menu-in-viper
//
//  Created by HANYU, Koji on 2023/04/11.
//

protocol View: AnyObject {
    func inject(_ presenter: Presentation)
    func viewDataDidUpdate()
    func menuWithStateViewDataDidUpdate()
}

protocol Presentation {
    func viewDidLoad()
    func showActionSheetButtonDidTap()
    var labelString: String { get }
    var buttonMenu: MenuViewData { get }
    var buttonMenuWithState: MenuViewData { get }
}

final class Presenter: Presentation {
    private weak var view: View?
    private let wireframe: Wireframe

    private var selectedActionString: String?
    private(set) var labelString: String = ""
    
    init(view: View,
         wireframe: Wireframe) {
        self.view = view
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        updateLabel(string: "hello world")
    }
    
    func showActionSheetButtonDidTap() {
        wireframe.showActionSheet() { [weak self] string in
            self?.updateLabel(string: string)
        }
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

    var buttonMenuWithState: MenuViewData {
        let handler: ActionViewData.Handler = { [weak self] action in
            let string = "\(action.title) tapped"
            self?.updateLabel(string: string)
            self?.updateState(selectedString: action.title)
        }
        
        let fooTitle = "foo action"
        let barTitle = "bar action"
        let fooActionIsOn = selectedActionString == fooTitle
        let barActionIsOn = selectedActionString == barTitle
        let fooAction = ActionViewData(title: "foo action", isOn: fooActionIsOn, handler: handler)
        let barAction = ActionViewData(title: "bar action", isOn: barActionIsOn, handler: handler)
            
        let actions = [fooAction, barAction]

        return MenuViewData(actions, title: "Menu (with state) sample")!
    }

    private func updateLabel(string: String) {
        labelString = string
        view?.viewDataDidUpdate()
    }
    
    private func updateState(selectedString: String) {
        self.selectedActionString = selectedString
        view?.menuWithStateViewDataDidUpdate()
    }
}
