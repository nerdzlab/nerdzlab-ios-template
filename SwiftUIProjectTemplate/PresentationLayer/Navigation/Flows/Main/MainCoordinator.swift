//
//  MainCoordinator.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class MainCoordinator {
    
    // MARK: - Internal types
    
    enum Tab: Identifiable, Hashable, CaseIterable {
        case home
        case settings
        
        var id: Self {
            self
        }
        
        var image: Image {
            switch self {
            case .home:
                return Image(systemName: "house")
                
            case .settings:
                return Image(systemName: "gearshape")
            }
        }
    }
    
    // MARK: - Properties(public)
    
    var selectedTab: Tab = .home
    
    // MARK: - Properties(private)
    
    @ObservationIgnored private lazy var homeCoordinator = HomeCoordinator()
    
    @ObservationIgnored private lazy var settingsCoordinator = SettingsCoordinator()
    
    // MARK: - Life cycle
    
    init() {
        setup()
    }
    
    // MARK: - Methods(public)
    
    func selectTab(_ tab: Tab) {
        selectedTab = tab
    }
    
    func makeHomeView() -> some View {
        HomeCoordinatorView(coordinator: homeCoordinator)
    }
    
    func makeSettingsView() -> some View {
        SettingsCoordinatorView(coordinator: settingsCoordinator)
    }
    
    // MARK: - Methods(private)
    
    private func setup() {
    }
}
