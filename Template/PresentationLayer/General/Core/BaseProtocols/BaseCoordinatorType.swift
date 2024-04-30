//
//  BaseCoordinatorType.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit

protocol BaseCoordinatorType {
    @discardableResult
    func start(completion: EmptyAction?) -> BaseScreenType
    
    @discardableResult
    func start() -> BaseScreenType
}

extension BaseCoordinatorType {
    func start() -> BaseScreenType {
        start(completion: nil)
    }
}
