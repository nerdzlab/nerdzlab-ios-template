//
//  BasePresenterType.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit

protocol BasePresenterType {
    func start(completion: EmptyAction?)
    func start()
}

extension BasePresenterType {
    func start() {
        start(completion: nil)
    }
}
