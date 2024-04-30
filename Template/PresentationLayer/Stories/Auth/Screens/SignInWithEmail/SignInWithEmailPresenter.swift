//
//  SignInWithEmailPresenter.swift
//  Template
//
//  Created by Vasyl Khmil on 17.03.2024.
//

import Foundation
import NerdzInject

actor SignInWithEmailPresenter {
    
    struct Events {
        var onFinish: EmptyAction?
    }
    
    // MARK: - Injects
    
    @ForceInject private var authRepository: AuthRepositoryType
    
    private let events: Events?
    private weak var screen: SignInWithEmailScreenType?
    
    init(_ screen: SignInWithEmailScreenType, events: Events? = nil) {
        self.screen = screen
        self.events = events
    }
    
    func start() async {
        await setupScreen()
    }
    
    private func setupScreen() async {
        screen?.onSignIn = { [weak self] email, password in
            Task { [weak self] in
                await self?.performSignIn(email: email, password: password)
            }
        }
    }
    
    private func performSignIn(email: String, password: String) async {
        do {
            _ = try await authRepository.loginUser(email: email, password: password)
            events?.onFinish?()
        }
        catch {
            await screen?.showError(error)
        }
    }
}
