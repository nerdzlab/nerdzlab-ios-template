//
//  OnboardingCoordinator.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class OnboardingCoordinator {
    
    // MARK: - Internal types
    
    enum NavigationRoute {
        case secondView
    }
    
    // MARK: - Properties(public)
    
    var navigationRoutes: [NavigationRoute] = []
    
    // MARK: - Methods(public)
    
    func makeInitialView() -> some View {
        EmptyView()
    }
    
    func makeSecondView() -> some View {
        EmptyView()
    }
}
