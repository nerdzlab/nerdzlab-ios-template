//
//  RootCoordinatorView.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct RootCoordinatorView: View {
    
    // MARK: - Properties(public)
    
    var body: some View {
        if coordinator.isOnboardingCompleted {
            coordinator.makeMainView()
        }
        else {
            coordinator.makeOnboardingView()
        }
    }
    
    // MARK: - Properties(private)
    
    @State private var coordinator: RootCoordinator
    
    // MARK: - Life cycle
    
    init(coordinator: RootCoordinator) {
        self._coordinator = State(wrappedValue: coordinator)
    }
}
