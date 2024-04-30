//
//  BaseSplitScreen.swift
//  Hubmee
//
//  Created by Roman Kovalchuk on 24.10.2023.
//

import UIKit
import NerdzUtils

final class BaseSplitScreen: BaseScreen, UINavigationControllerDelegate {
    
    enum Position {
        case primary
        case secodary(reset: Bool = true)
    }
    
    private(set) lazy var primaryScreen: BaseNavigationScreen = {
        let screen = BaseNavigationScreen()
        
        screen.delegate = self
        
        return screen
    }()
    
    private(set) lazy var secondaryScreen: BaseNavigationScreen = {
        BaseNavigationScreen(rootViewController: secondaryRootScreen)
    }()
    
    let secondaryRootScreen = SecondaryPlaceholderScreen()
    
    @IBOutlet private var primaryContainer: UIView! {
        didSet {
            nz.easilyAddChild(primaryScreen, on: primaryContainer)
            setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .compact), forChild: primaryScreen)
        }
    }
    
    @IBOutlet private var secondaryContainer: UIView! {
        didSet {
            nz.easilyAddChild(secondaryScreen, on: secondaryContainer)
            setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .compact), forChild: secondaryScreen)
        }
    }
    
    // MARK: - Override(Lifecycle) -

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: - Methods (public)
    
    func resetSecondary() {
        if let newController = (primaryScreen.topViewController as? BaseScreenType) {
            secondaryRootScreen.placeholder = newController.secondaryViewPlaceholder
        }
        
        secondaryScreen.setViewControllers([secondaryRootScreen], animated: false)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        resetSecondary()
    }
}
