//
//  SwiftUIProjectTemplateApp.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import NerdzInject

@main
struct SwiftUIProjectTemplateApp: App {
    
    // MARK: - Properties(private)
    
    @State private var rootCoordinator = RootCoordinator()
    
    // MARK: - Properties(public)
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(coordinator: rootCoordinator)
        }
    }
}
