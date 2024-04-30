//
//  RootCoordinator.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit
import NerdzInject
import NerdzUtils
import NerdzNetworking
import Firebase
import NerdzEvents
import NerdzAppUpdates
import IQKeyboardManagerSwift
import Nuke

final class RootCoordinator: BaseCoordinatorType {
    
    // MARK: - Internal types -
    
    private enum Constants {
        #warning("Change to real store URL")
        static let appStoreUrl = "https://apps.apple.com/us/app/digital-planner-hubmee/id1357144691"
    }
    
    // MARK: - Injects
    
    @ForceInject private var authRepository: AuthRepositoryType

    // MARK: - Methods(private) -
    
    private weak var containerScreen: RootScreen?
    private let disposeBag = DisposeBag()
    
    private weak var softUpdatePopup: UIAlertController?
    private var pendingShowSoftUpdate: Bool = false
    
    private lazy var appVersionVerifyer: VersionVerifier = {
        let provider = AppStoreVersionProvider(country: .unitedStates)

        let verifier = VersionVerifier(
            versionDataProvider: provider,
            loadingIndicationMode: .none,
            softUpdateMode: .custom({ [weak self] _ in self?.showSoftUpdatePopupIfNeeded() }),
            hardUpdateMode: .screen(configureHardUpdateScreen())
        )

        return verifier
    }()
    
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // MARK: - Life cycle -
    
    init(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.launchOptions = launchOptions
    }
    
    // MARK: - Methods(public) -
    
    func start(completion: EmptyAction? = nil) -> BaseScreenType {
        configuerContainerScreen(completion)
    }
    
    // MARK: - Methods(private) -
    
    private func configureHardUpdateScreen() -> ForceUpdateScreen {
        let forceUpdateScreen = ForceUpdateScreen()
        
        forceUpdateScreen.onUpdateSelected = {
            if let url = URL(string: Constants.appStoreUrl) {
                UIApplication.shared.open(url)
            }
        }
        
        return forceUpdateScreen
    }
    
    private func showSoftUpdatePopupIfNeeded() {
        #warning("Configure propperly the logic for soft update. Curently it will show empty alert")
        guard let container = containerScreen else {
            pendingShowSoftUpdate = true
            return
        }
        
        guard softUpdatePopup == nil else {
            return
        }
        
        let alert = UIAlertController(
            title: "", 
            message: "", 
            preferredStyle: .alert
        )
        
        alert.popoverPresentationController?.sourceRect = CGRect(
            x: container.view.bounds.midX,
            y: container.view.bounds.midY,
            width: 0,
            height: 0
        )
        
        alert.popoverPresentationController?.sourceView = container.view
        alert.popoverPresentationController?.permittedArrowDirections = []
        
        containerScreen?.present(alert, animated: true)
        
        pendingShowSoftUpdate = false
        softUpdatePopup = alert
    }
    
    private func configuerContainerScreen(_ completion: EmptyAction?) -> BaseScreenType {
        let screen = RootScreen()
        screen.startControllingObject(self)
        containerScreen = screen
        configureRepositories()
        
        Task {
            await configureEnvironment()
            await configureInitialState()
        }

        return screen
    }
    
    @MainActor
    private func configureInitialState() {
        #warning("Logic here should define from what point to start. Currently starting from aurth always for simplicity")
        showAuthentication()
    }
    
    private func showAuthentication() {
        clearState()
        
        let coordinator = AuthCoordinator()
        let screen = coordinator.start()
        
        containerScreen?.nz.easilyAddChild(screen)
    }
    
    private func clearState() {
        for child in containerScreen?.children ?? [] {
            child.removeFromParent()
            child.view.removeFromSuperview()
        }
    }
    
    private func configureEnvironment() async {
        await verifyAppVersion()
        
        configureListeners()
        configureNuke()
        
        
        await configureNetworking()
        await configureNetworkDebuging()
        await configureFirebase()
        await configureKeyboardManager()
    }
    
    private func configureListeners() {
        UIApplicationEvents.events
            .didBecomeActiveEvent
            .listen(signedBy: self)
            .dispose(by: disposeBag)
            .onQueue(.main)
            .perform { [weak self] in
                Task { [weak self] in
                    await self?.verifyAppVersion()
                }
            }
    }
    
    @MainActor
    private func verifyAppVersion() async {
        #if DEBUG
        return
        #endif
        
        await withCheckedContinuation { [weak self] continiation in
            self?.appVersionVerifyer.verifyVersion { result in
                if case .success(let checkResult) = result, checkResult.type != .hardUpdate {
                    continiation.resume()
                }
                else if case .failure = result {
                    continiation.resume()
                }
            }
        }
    }
    
    @MainActor
    private func configureFirebase() {
        FirebaseApp.configure()
    }
    
    @MainActor
    private func configureNetworkDebuging() {
        #if DEBUG || DEV_ENV
        Atlantis.start()
        #endif
    }
    
    @MainActor
    private func configureNetworking() {
        let coder = JSONDecoder()
        coder.keyDecodingStrategy = .convertFromSnakeCase
        coder.dateDecodingStrategy = .secondsSince1970

        let endpoint = Endpoint(baseUrl: Environment.current.apiBaseURL, decoder: coder)
        
        endpoint.handleAppMoveToBackground = true

        endpoint.headers.contentType = .application(.json)
        endpoint.headers.accept = .application(.json)
        endpoint.headers.language = Locale.current.language.languageCode?.identifier
        
        endpoint.observation.register(for: .unauthorized) { [weak self] _, _ in
            self?.forceLogout()
        }
                
        endpoint.headers.authToken = authRepository.authToken.flatMap { .bearer($0) }
        
        Endpoint.default = endpoint
        NerdzInject.shared.registerObject(endpoint)
    }
    
    private func forceLogout() {
        #warning("Implement logout logic")
    }
    
    private func configureRepositories() {
        NerdzInject.shared.registerObject(AuthRepository(), for: AuthRepositoryType.self)
    }
    
    @MainActor
    private func configureKeyboardManager() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private func configureNuke() {
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
    }
}
