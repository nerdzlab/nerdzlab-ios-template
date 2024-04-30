//
//  CompactNavigationProcessor.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 30.11.2023.
//

import UIKit

final class CompactNavigationProcessor: NavigationProcessor {
    private let navigationScreen = BaseNavigationScreen()
    
    var container: BaseScreenType {
        navigationScreen
    }
    
    func registerCoordinator(
        _ coordinator: AnyObject,
        in position: BaseSplitScreen.Position,
        with initialScreenToPush: UIViewController? = nil
    ) {
        navigationScreen.registerCoordinator(coordinator, with: initialScreenToPush)
    }
    
    @discardableResult
    func popToRoot(of coordinator: AnyObject, animated: Bool) -> Bool {
        navigationScreen.popToRoot(of: coordinator, animated: animated)
    }
    
    @discardableResult
    func pop(to coordinator: AnyObject, animated: Bool) -> Bool {
        navigationScreen.pop(to: coordinator, animated: animated)
    }
    
    func showAsPrimary(_ screen: BaseScreenType) {
        navigationScreen.pushViewController(screen, animated: true)
    }
    
    func showAsSecondary(_ screen: BaseScreenType, reset: Bool) {
        navigationScreen.pushViewController(screen, animated: true)
    }
    
    func hideLastSecondaryScreen(animated: Bool) {
        navigationScreen.popViewController(animated: animated)
    }
    
    func reset(animated: Bool) {
        navigationScreen.popToRootViewController(animated: animated)
    }
}
