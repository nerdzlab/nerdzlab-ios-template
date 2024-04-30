//
//  BaseNavigatableCoordinator.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 07.07.2023.
//

import UIKit
import NerdzInject

class BaseNavigatableCoordinator: BaseNavigatableCoordinatorType {
    let containerScreen: BaseNavigationScreen
    
    init(containerScreen: BaseNavigationScreen? = nil) {
        self.containerScreen = containerScreen ?? BaseNavigationScreen()
    }
    
    @discardableResult
    func start(completion: EmptyAction?) -> BaseScreenType {
        completion?()
        
        return containerScreen
    }
}
