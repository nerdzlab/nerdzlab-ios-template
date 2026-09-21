//
//  HomeCoordinatorView.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct HomeCoordinatorView: View {
    
    // MARK: - Properties(public)
    
    var body: some View {
        NavigationStack {
            coordinator.makeInitialView()
        }
    }
    
    // MARK: - Properties(private)
    
    @State private var coordinator: HomeCoordinator
    
    // MARK: - Life cycle
    
    init(coordinator: HomeCoordinator) {
        self._coordinator = State(wrappedValue: coordinator)
    }
}
