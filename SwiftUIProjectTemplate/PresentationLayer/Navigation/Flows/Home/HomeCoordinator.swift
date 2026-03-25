//
//  HomeCoordinator.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Combine
import SwiftUI

@MainActor
@Observable
final class HomeCoordinator {
    
    // MARK: - Life cycle
    
    init() {
    }
    
    // MARK: - Methods(public)
    
    func makeInitialView() -> some View {
        Text("Home View")
    }
}
