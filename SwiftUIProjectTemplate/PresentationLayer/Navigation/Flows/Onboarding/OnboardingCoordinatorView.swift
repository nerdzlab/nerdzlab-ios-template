//
//  OnboardingCoordinatorView.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    
    // MARK: - Properties(public)
        
    var body: some View {
        NavigationStack(path: $coordinator.navigationRoutes) {
            coordinator.makeInitialView()
                .navigationDestination(for: OnboardingCoordinator.NavigationRoute.self) { route in
                    switch route {
                    case .secondView:
                        coordinator.makeSecondView()
                    }
                }
        }
    }
    
    // MARK: - Properties(private)
    
    @State private var coordinator: OnboardingCoordinator
    
    // MARK: - Life cycle
    
    init(coordinator: OnboardingCoordinator) {
        self._coordinator = State(wrappedValue: coordinator)
    }
}
