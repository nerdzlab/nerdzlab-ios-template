//
//  BaseContentCoordinator.swift
//  Hubmee
//
//  Created by Roman Kovalchuk on 24.10.2023.
//

import UIKit
import NerdzUtils

class BaseContentCoordinator: BaseContentCoordinatorType {
    
    let navigationProcessor: NavigationProcessor
    
    init(navigationProcessor: NavigationProcessor? = nil) {
        self.navigationProcessor = 
        navigationProcessor ?? 
        (
            UITraitCollection.current.horizontalSizeClass == .compact ? 
            CompactNavigationProcessor() : 
            RegularNavigationProcessor()
        )
    }
    
    @discardableResult
    func start(completion: EmptyAction?) -> BaseScreenType {
        completion?()
        
        return navigationProcessor.container
    }
}
