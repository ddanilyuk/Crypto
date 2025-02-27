//
//  AppDelegate.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import UIKit
import ComposableArchitecture

final class AppDelegate: NSObject, UIApplicationDelegate {

    // MARK: - Store

    lazy var appDelegateStore = CryptoApp.store.scope(
        state: \App.State.appDelegate,
        action: App.Action.appDelegate
    )
    lazy var viewStore: ViewStore<State, Action> = ViewStore(appDelegateStore)

    // MARK: - Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        viewStore.send(.didFinishLaunching)
        return true
    }

}
