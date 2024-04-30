//
//  RegularNavigationScreen.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 30.11.2023.
//

import UIKit

final class RegularNavigationProcessor: NavigationProcessor {
    
    private let splitScreen = BaseSplitScreen()
    
    var container: BaseScreenType {
        splitScreen
    }
    
    func registerCoordinator(
        _ coordinator: AnyObject,
        in position: BaseSplitScreen.Position,
        with initialScreenToPush: UIViewController? = nil
    ) {
        switch position {
        case .primary:
            splitScreen.primaryScreen.registerCoordinator(coordinator, with: initialScreenToPush)
            
        case .secodary(let reset):
            if reset {
                splitScreen.secondaryScreen.setViewControllers([], animated: false)
            }
            
            splitScreen.secondaryScreen.registerCoordinator(coordinator, with: initialScreenToPush)
        }
    }
    
    @discardableResult
    func popToRoot(of coordinator: AnyObject, animated: Bool) -> Bool {
        if splitScreen.primaryScreen.popToRoot(of: coordinator, animated: animated) {
            splitScreen.resetSecondary()
            return true
        }
        else {
            return splitScreen.secondaryScreen.popToRoot(of: coordinator, animated: animated)
        }
    }
    
    @discardableResult
    func pop(to coordinator: AnyObject, animated: Bool) -> Bool {
        if splitScreen.primaryScreen.pop(to: coordinator, animated: animated) {
            splitScreen.resetSecondary()
            return true
        }
        else {
            return splitScreen.secondaryScreen.pop(to: coordinator, animated: animated)
        }
    }
    
    func showAsPrimary(_ screen: BaseScreenType) {
        if splitScreen.primaryScreen.viewControllers.isEmpty {
            splitScreen.primaryScreen.setViewControllers([screen], animated: false)
        }
        else {
            splitScreen.primaryScreen.pushViewController(screen, animated: true)
        }
    }
    
    func showAsSecondary(_ screen: BaseScreenType, reset: Bool) {
        if reset {
            splitScreen.secondaryScreen.setViewControllers([screen], animated: false)
        }
        else if splitScreen.secondaryScreen.viewControllers.first === splitScreen.secondaryRootScreen {
            splitScreen.secondaryScreen.setViewControllers([screen], animated: false)
        }
        else if splitScreen.secondaryScreen.viewControllers.isEmpty {
            splitScreen.secondaryScreen.setViewControllers([screen], animated: false)
        }
        else {
            splitScreen.secondaryScreen.pushViewController(screen, animated: true)
        }
    }
    
    func hideLastSecondaryScreen(animated: Bool) {
        splitScreen.secondaryScreen.popViewController(animated: animated)
    }
    
    func reset(animated: Bool) {
        splitScreen.primaryScreen.popToRootViewController(animated: animated)
    }
}
