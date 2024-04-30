//
//  BaseNavigationScreen.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit
import NerdzUtils

class BaseNavigationScreen: UINavigationController, BaseScreenType {
    
    var onViewDidLoad: EmptyAction?
    var onViewWillAppear: EmptyAction?
    var onViewDidAppear: EmptyAction?
    var onViewWillDisappear: EmptyAction?
    var onViewDidDisappear: EmptyAction?
        
    private var registeredCoordinators: [(index: Int, coordinator: Weak<AnyObject>)] = []
        
    // MARK: - Override(Lifecycle) -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        onViewDidLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    // MARK: - Override(Methods) -
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        let controller = super.popViewController(animated: animated)
        
        cleanupCoordinators()
        
        return controller
    }
    
    // MARK: - Methods(public) -
    
    func clearState(animated: Bool, completion: EmptyAction? = nil) {
        guard presentedViewController != nil else {
            completion?()
            return
        }
        
        dismiss(animated: animated, completion: completion)
    }
    
    func registerCoordinator(
        _ coordinator: AnyObject,
        with initialScreenToPush: UIViewController? = nil
    ) {
        if let screen = initialScreenToPush {
            if viewControllers.isEmpty {
                setViewControllers([screen], animated: false)
            }
            else {
                pushViewController(screen, animated: true)
            }
        }
        
        if viewControllers.last === initialScreenToPush {
            registeredCoordinators.append((viewControllers.count - 1, Weak(coordinator)))
        }
        else {
            registeredCoordinators.append((viewControllers.count, Weak(coordinator)))
        }
    }
    
    @discardableResult
    func popToRoot(of coordinator: AnyObject, animated: Bool) -> Bool {
        let info = registeredCoordinators.first {
            $0.coordinator.object === coordinator
        }
        
        guard let index = info?.index else {
            return false
        }
        
        guard let controller = viewControllers[safe: index] else {
            return false
        }
        
        popToViewController(controller, animated: animated)
        
        return true
    }
    
    @discardableResult
    func pop(to coordinator: AnyObject, animated: Bool) -> Bool {
        
        let sortedCoordinators = registeredCoordinators.sorted {
            $0.index < $1.index
        }
        
        let coordinatorIndex = sortedCoordinators.firstIndex {
            $0.coordinator.object === coordinator
        }
        
        guard let index = coordinatorIndex else {
            return false
        }
        
        guard let nextCoordinatorIndex = sortedCoordinators[safe: index + 1]?.index else {
            /// There is no next coordinator. So it is already popped to coordinator
            return true
        }
        
        guard let controllerToPop = viewControllers[safe: nextCoordinatorIndex - 1] else {
            return false
        }
        
        popToViewController(controllerToPop, animated: animated)
        
        cleanupCoordinators()
        
        return true
    }
    
    // MARK: - Methods (private) -
    
    private func setup() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        
        #warning("Define navigation basic setup before start")
        
        subscribeOnControllersUpdate()
    }
    
    private func subscribeOnControllersUpdate() {
        _ = observe(\.viewControllers) { [weak self] _, _ in
            self?.cleanupCoordinators()
        }
    }
    
    private func cleanupCoordinators() {
        let controllersCount = viewControllers.count
        
        registeredCoordinators.removeAll {
            $0.index > controllersCount
        }
    }
}

extension BaseNavigationScreen: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
}
