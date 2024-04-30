//
//  AppDelegate.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit

#warning("Do not forget to modify all values in xcconfig files")
#warning("Do not forget to replace GoogleService-Info.plist files with your. As current one are mocked.")
#warning("Do not forget to change project name and all schemas name")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        configureAppStart(with: launchOptions)
    }
}

private extension AppDelegate {
    func configureAppStart(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRootCoordinator(with: launchOptions)

        return true
    }

    func configureRootCoordinator(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = RootCoordinator(launchOptions: launchOptions).start()
        window.makeKeyAndVisible()
        self.window = window
    }
}
