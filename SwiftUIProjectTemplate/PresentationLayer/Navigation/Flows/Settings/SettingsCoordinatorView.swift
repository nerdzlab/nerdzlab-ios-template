//
//  SettingsCoordinatorView.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct SettingsCoordinatorView: View {
    
    // MARK: - Properties(public)
    
    var body: some View {
        NavigationStack {
            coordinator.makeInitialView()
        }
    }
    
    // MARK: - Properties(private)
    
    @State private var coordinator: SettingsCoordinator
    
    // MARK: - Life cycle
    
    init(coordinator: SettingsCoordinator) {
        self._coordinator = State(wrappedValue: coordinator)
    }
}
