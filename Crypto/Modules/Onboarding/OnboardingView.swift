//
//  OnboardingView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {

    let store: Store<Onboarding.State, Onboarding.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { geometry in
                ZStack{
                    Rectangle()
                        .fill(Asset.Colors.corbeau.swiftUIColor)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()

                        TabView(selection: viewStore.binding(\.$selectedStep)) {
                            ForEach(viewStore.steps, id: \.self) { step in
                                step.image.swiftUI
                                    .tag(step)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .animation(.default, value: viewStore.selectedStep)

                        Spacer()

                        bottomView
                            .padding(20)
                            .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
        }
    }

    private var bottomView: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Rectangle()
                    .fill(Asset.Colors.latinCharm.swiftUIColor)
                    .cornerRadius(30)
                VStack {
                    Spacer()
                    Text(viewStore.selectedStep.title)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Asset.Colors.white.swiftUIColor)
                    Spacer()
                    Text(viewStore.selectedStep.description)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        viewStore.send(.nextStep)
                    } label: {
                        Text("Continue")
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            Asset.Colors.strawberryDreams.swiftUIColor,
                                            Asset.Colors.watermelonJuice.swiftUIColor
                                        ]
                                    ),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(56 / 2)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Asset.Colors.white.swiftUIColor)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }

}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            OnboardingView(
                store: Store(
                    initialState: Onboarding.State(),
                    reducer: Onboarding.reducer,
                    environment: Onboarding.Environment(
                        userDefaultsService: .mock
                    )
                )
            )
        }
    }
    
}
