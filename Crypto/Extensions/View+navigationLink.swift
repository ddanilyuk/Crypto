//
//  View+navigationLink.swift
//  Crypto
//
//  Created by Denys Danyliuk on 27.07.2022.
//

import SwiftUI
import CasePaths

struct NavigationModifier<Value, WrappedDestination: View>: ViewModifier {

    let value: Binding<Value?>
    let destination: (Value) -> WrappedDestination

    public init(
        unwrapping value: Binding<Value?>,
        @ViewBuilder destination: @escaping (Value) -> WrappedDestination
    ) {
        self.value = value
        self.destination = destination
    }

    func body(content: Content) -> some View {
        ZStack {
            NavigationLink(
                destination: Binding(unwrapping: value)
                    .map { value in destination(value.wrappedValue) },
                isActive: value.isPresent(),
                label: { Text("") }
            )
            content
        }
    }

}

extension View {

    func navigationLink<Value, WrappedDestination: View>(
        unwrapping value: Binding<Value?>,
        @ViewBuilder destination: @escaping (Value) -> WrappedDestination
    ) -> some View {
        modifier(NavigationModifier(unwrapping: value, destination: destination))
    }

    func navigationLink<Enum, Case, WrappedDestination: View>(
        unwrapping enum: Binding<Enum?>,
        case casePath: CasePath<Enum, Case>,
        @ViewBuilder destination: @escaping (Case) -> WrappedDestination
    ) -> some View {
        modifier(NavigationModifier(
            unwrapping: `enum`.case(casePath),
            destination: destination
        ))
    }

}

extension Binding {

    init?(unwrapping base: Binding<Value?>) {
        self.init(unwrapping: base, case: /Optional.some)
    }

    init?<Enum>(unwrapping enum: Binding<Enum>, case casePath: CasePath<Enum, Value>) {
        guard var `case` = casePath.extract(from: `enum`.wrappedValue)
        else { return nil }

        self.init(
            get: {
                `case` = casePath.extract(from: `enum`.wrappedValue) ?? `case`
                return `case`
            },
            set: {
                `case` = $0
                `enum`.transaction($1).wrappedValue = casePath.embed($0)
            }
        )
    }

    func `case`<Enum, Case>(_ casePath: CasePath<Enum, Case>) -> Binding<Case?> where Value == Enum? {
        .init(
            get: { wrappedValue.flatMap(casePath.extract(from:)) },
            set: { newValue, transaction in
                self.transaction(transaction).wrappedValue = newValue.map(casePath.embed)
            }
        )
    }

    func isPresent<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: {
                wrappedValue != nil
            },
            set: { isPresent, transaction in
                if !isPresent {
                    self.transaction(transaction).wrappedValue = nil
                }
            }
        )
    }

    func isPresent<Enum, Case>(_ casePath: CasePath<Enum, Case>) -> Binding<Bool> where Value == Enum? {
        self.case(casePath).isPresent()
    }

}

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}
