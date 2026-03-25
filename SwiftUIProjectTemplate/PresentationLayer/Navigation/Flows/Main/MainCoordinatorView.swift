//
//  MainCoordinatorView.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct MainCoordinatorView: View {
    
    // MARK: - Properties(public)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .ignoresSafeArea()
            
            tabView
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Properties(private)
    
    private var tabView: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(MainCoordinator.Tab.allCases) { tab in
                switch tab {
                case .home:
                    coordinator.makeHomeView()
                        .tag(tab)
                    
                case .settings:
                    coordinator.makeSettingsView()
                        .tag(tab)
                }
            }
        }
        .padding(.bottom, 50)
    }
    
    @State private var coordinator: MainCoordinator
    
    // MARK: - Life cycle
    
    init(coordinator: MainCoordinator) {
        self._coordinator = State(wrappedValue: coordinator)
    }
    
    // MARK: - Methods(private)
    
    private func getTabView(for tab: MainCoordinator.Tab) -> some View {
        Button(
            action: {
                withAnimation {
                    coordinator.selectTab(tab)
                }
            },
            label: {
                VStack(spacing: 8) {
                    tab.image
                        .resizable()
                        .foregroundStyle(
                            tab == coordinator.selectedTab
                            ? Color.green
                            : Color.gray
                        )
                        .frame(width: 24, height: 24)
                    
                    Rectangle()
                        .fill(
                            tab == coordinator.selectedTab
                            ? Color.green
                            : .clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .frame(width: 24, height: 2)
                }
            }
        )
    }
}
