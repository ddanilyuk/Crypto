//
//  ProfileHeaderView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct ProfileHeaderView: View {

    struct ViewState: Equatable {
        let user: User
    }

    enum ViewAction {
        case depositButtonTapped
        case withdrawButtonTapped
    }

    @ObservedObject var viewStore: ViewStore<ViewState, ViewAction>

    var body: some View {
        VStack{
            header
            balance
            footer
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Wellcome back")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)

                Text(viewStore.user.name + " 👋")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)
            }

            Spacer()

            KFImage.url(viewStore.user.imageURL)
                .resizable()
                .diskCacheExpiration(.never)
                .memoryCacheExpiration(.never)
                .placeholder {
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGroupedBackground))

                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .clipped()
        }
        .padding(16)
    }

    private var balance: some View {
        ZStack {
            Circle()
                .fill(Asset.Colors.latinCharm.swiftUIColor)
                .opacity(0.5)
                .frame(width: 180, height: 180)

            Circle()
                .fill(Asset.Colors.latinCharm.swiftUIColor)
                .opacity(0.5)
                .frame(width: 180, height: 180)
                .radianGradientForeground(
                    colors: [Asset.Colors.strawberryDreams.swiftUIColor, .clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 100
                )

            Text(viewStore.user.balance)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
        }
    }

    private var footer: some View {
        HStack(spacing: 10) {
            ProfileHeaderButton(
                title: "Deposit",
                action: { viewStore.send(.depositButtonTapped) }
            )

            ProfileHeaderButton(
                title: "Withdraw",
                action: { viewStore.send(.withdrawButtonTapped) }
            )
        }
        .padding(.top, 32)
        .padding(.trailing, 20)
        .padding(.leading, 20)
        .padding(.bottom, 47)
    }

}

// MARK: - ViewState

extension Profile.State {

    var profileHeaderView: ProfileHeaderView.ViewState {
        ProfileHeaderView.ViewState(
            user: user
        )
    }

}

// MARK: - ViewAction

extension Profile.Action {

    static func profileHeaderView(_ viewAction: ProfileHeaderView.ViewAction) -> Self {
        switch viewAction {
        case .depositButtonTapped:
            return .deposit

        case .withdrawButtonTapped:
            return .withdraw
        }
    }

}
