//
//  BaseScreen.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit

class BaseScreen: UIViewController, BaseScreenType {
    
    // MARK: - Properties(Public)
    
    var onViewDidLoad: EmptyAction?
    var onViewWillAppear: EmptyAction?
    var onViewDidAppear: EmptyAction?
    var onViewWillDisappear: EmptyAction?
    var onViewDidDisappear: EmptyAction?
    
    // MARK: - Properties (public) -
    
    var pendingViewLoadUpdates: [EmptyAction] = []
    var pendingViewAppearUpdates: [EmptyAction] = []
    
    var secondaryViewPlaceholder: String? {
        nil
    }
    
    // MARK: - Properties (Private)
    
    private var controllingObjects: [String: Any] = [:]
    private var isViewAppeared: Bool = false
    
    // MARK: - Override(Lifecycle) -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        handlePendingUpdates()
        onViewDidLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isViewAppeared = true
        handlePendingAppearUpdates()
        
        onViewWillAppear?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        onViewDidAppear?()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        onViewWillDisappear?()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        onViewDidDisappear?()
    }
    
    // MARK: - Methods (public)
    
    @discardableResult
    func startControllingObject(_ object: Any) -> String {
        let token = UUID().uuidString
        controllingObjects[token] = object
        return token
    }
    
    @discardableResult
    func removeControllingObject(by token: String) -> Any? {
        controllingObjects.removeValue(forKey: token)
    }
    
    @discardableResult
    func afterViewLoaded(perform action: @escaping EmptyAction) -> Bool {
        if isViewLoaded {
            action()
            return true
        }
        else {
            pendingViewLoadUpdates.append(action)
            return false
        }
    }
    
    @discardableResult
    func afterViewWillAppear(perform action: @escaping EmptyAction) -> Bool {
        if isViewAppeared {
            action()
            return true
        }
        else {
            pendingViewAppearUpdates.append(action)
            return false
        }
    }
    
    // MARK: - Methods(private) -
    
    private func handlePendingUpdates() {
        for action in pendingViewLoadUpdates {
            action()
        }
        
        pendingViewLoadUpdates.removeAll()
    }
    
    private func handlePendingAppearUpdates() {
        for action in pendingViewAppearUpdates {
            action()
        }
        
        pendingViewAppearUpdates.removeAll()
    }
}
