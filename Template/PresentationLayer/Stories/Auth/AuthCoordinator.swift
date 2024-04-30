//
//  AuthCoordinator.swift
//  Template
//
//  Created by Vasyl Khmil on 17.03.2024.
//

import UIKit

final class AuthCoordinator: BaseContentCoordinator {

    // MARK: - Methods(override)
    
    override func start(completion: EmptyAction?) -> BaseScreenType {
        super.start { [weak self] in
            self?.setupInitialState()
            completion?()
        }
    }
    
    // MARK: - Methods(private)
    
    private func setupInitialState() {
        let events = SignInWithEmailPresenter.Events(
            onFinish: {
                #warning("Do something here")
            }
        )
        
        let screen = SignInWithEmailScreen()
        let presenter = SignInWithEmailPresenter(screen, events: events)
        screen.startControllingObject(presenter)
        
        navigationProcessor.registerCoordinator(self, in: .primary, with: screen)
        
        Task {
            await presenter.start()
        }
    }
}
