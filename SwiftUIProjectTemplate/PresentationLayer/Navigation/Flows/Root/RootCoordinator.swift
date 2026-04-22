//
//  RootCoordinator.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import Combine
import NerdzInject

@MainActor
@Observable
final class RootCoordinator {

    // MARK: - Properties(public)

    var isOnboardingCompleted: Bool = false

    // MARK: - Properties(private)

    @ObservationIgnored private lazy var onboardingCoordinator = OnboardingCoordinator()
    @ObservationIgnored private lazy var mainCoordinator = MainCoordinator()

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Life cycle

    init() {
        setup()
    }

    // MARK: - Methods(public)

    func makeOnboardingView() -> some View {
        OnboardingCoordinatorView(coordinator: onboardingCoordinator)
            .toastable()
    }

    func makeMainView() -> some View {
        MainCoordinatorView(coordinator: mainCoordinator)
            .toastable()
    }

    // MARK: - Methods(private)

    private func setup() {
        setupEnvironment()
        setupListeners()
        setupNavigationBar()
        setupInitialState()
    }

    private func setupEnvironment() {
        setupDependencies()
    }

    private func setupDependencies() {
        NerdzInject.shared.registerObject(ToastManager())
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        appearance.backgroundImage = nil
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.buttonAppearance = buttonAppearance
        appearance.backButtonAppearance = buttonAppearance
        appearance.doneButtonAppearance = buttonAppearance
               
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func setupInitialState() {
        isOnboardingCompleted = true
    }
    
    private func setupListeners() {
    }
}
