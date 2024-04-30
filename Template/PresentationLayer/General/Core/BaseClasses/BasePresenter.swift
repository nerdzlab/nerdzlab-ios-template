//
//  BasePresenter.swift
//  Template
//
//  Created by NerdzLab
//

import Foundation

class BasePresenter: BasePresenterType {

    func start(completion: EmptyAction? = nil) {
        completion?()
    }

    func start() {
        start(completion: nil)
    }
}
