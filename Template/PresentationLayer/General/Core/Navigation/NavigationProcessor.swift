//
//  NavigationProcessor.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 30.11.2023.
//

import UIKit

protocol NavigationProcessor {
    
    var container: BaseScreenType { get }
    
    func registerCoordinator(
        _ coordinator: AnyObject,
        in position: BaseSplitScreen.Position,
        with initialScreenToPush: UIViewController? 
    )
    
    @discardableResult
    func popToRoot(of coordinator: AnyObject, animated: Bool) -> Bool
    
    @discardableResult
    func pop(to coordinator: AnyObject, animated: Bool) -> Bool
    
    func showAsPrimary(_ screen: BaseScreenType)
    
    func showAsSecondary(_ screen: BaseScreenType, reset: Bool)
    
    func hideLastSecondaryScreen(animated: Bool)
    
    func reset(animated: Bool)
}
