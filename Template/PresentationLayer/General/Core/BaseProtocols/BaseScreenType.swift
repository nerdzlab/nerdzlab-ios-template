//
//  BaseScreenType.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit

protocol BaseScreenType where Self: UIViewController {
    var onViewDidLoad: EmptyAction? { get set }
    var onViewWillAppear: EmptyAction? { get set }
    var onViewDidAppear: EmptyAction? { get set }
    var onViewWillDisappear: EmptyAction? { get set }
    var onViewDidDisappear: EmptyAction? { get set }
    
    var secondaryViewPlaceholder: String? { get }  

    @MainActor
    func showErrorMessage(_ message: String)

    @MainActor
    func showSuccess(_ message: String)

    @MainActor
    func showInfo(_ message: String)

    @MainActor
    func showWarning(_ message: String)
}

extension BaseScreenType {
    var secondaryViewPlaceholder: String? {
        nil
    }
}

extension BaseScreenType {
    @MainActor
    func showError(_ error: Error) {
        showErrorMessage(error.localizedDescription)
    }
    
    @MainActor
    func showSuccess(_ message: String) {
        #warning("Define or delete this logic before start")
    }

    @MainActor
    func showInfo(_ message: String) {
        #warning("Define or delete this logic before start")
    }

    @MainActor
    func showWarning(_ message: String) {
        #warning("Define or delete this logic before start")
    }

    @MainActor
    func showErrorMessage(_ message: String) {
        #warning("Define or delete this logic before start")
    }
}
