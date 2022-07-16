//
//  UserDefaultsService.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import Foundation
import IdentifiedCollections

protocol UserDefaultsServiceable {

    // MARK: - Set

    func set<T: Codable>(
        _ value: T,
        for defaultKey: UserDefaultKey<T>
    )

    func set<T: Codable>(
        _ value: T,
        for defaultKey: UserDefaultKey<T>,
        encoder: JSONEncoder
    )

    // MARK: - Get

    func get<T: Codable>(
        for defaultKey: UserDefaultKey<T>
    ) -> T?

    func get(
        for defaultKey: UserDefaultKey<Bool>
    ) -> Bool

    // MARK: - Remove

    func remove<T: Codable>(for key: UserDefaultKey<T>)

}


struct UserDefaultsService: UserDefaultsServiceable {

    init(_ defaults: UserDefaults) {
        self.defaults = defaults
    }

    // MARK: - Properties

    private let defaults: UserDefaults

    // MARK: - Set

    func set<T: Codable>(
        _ value: T,
        for defaultKey: UserDefaultKey<T>
    ) {
        guard let encoded = try? JSONEncoder().encode(value) else {
            return
        }
        defaults.set(encoded, forKey: defaultKey.key)
    }

    func set<T: Codable>(
        _ value: T,
        for defaultKey: UserDefaultKey<T>,
        encoder: JSONEncoder = JSONEncoder()
    ) {
        guard let encoded = try? encoder.encode(value) else {
            return
        }
        defaults.set(encoded, forKey: defaultKey.key)
    }

    // MARK: - Get

    func get<T: Codable>(
        for defaultKey: UserDefaultKey<T>
    ) -> T? {

        return get(for: defaultKey.key)
    }

    func get(
        for defaultKey: UserDefaultKey<Bool>
    ) -> Bool {
        return get(for: defaultKey) ?? false
    }

    private func get<T: Codable>(
        for key: String
    ) -> T? {
        guard
            let data = defaults.object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(T.self, from: data)
        else {
            return nil
        }
        return value
    }

    // MARK: - Remove

    func remove<T: Codable>(
        for defaultKey: UserDefaultKey<T>
    ) {
        defaults.removeObject(forKey: defaultKey.key)
        defaults.synchronize()
    }

}

struct UserDefaultKey<T: Codable> {
    var key: String

    init(key: String = #function) {
        self.key = key
    }
}

extension UserDefaultKey {

    static var onboardingPassed: UserDefaultKey<Bool> { .init() }

}

// MARK: - UserDefaultsClient

extension UserDefaultsServiceable where Self == UserDefaultsService {

    static func live() -> UserDefaultsServiceable {
        UserDefaultsService(UserDefaults.standard)
    }

    static var mock: UserDefaultsServiceable {
        UserDefaultsService(UserDefaults(suiteName: "mock")!)
    }

}
