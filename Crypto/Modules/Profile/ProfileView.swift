//
//  ProfileView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {

    let store: Store<Profile.State, Profile.Action>

    var body: some View {
        WithViewStore(store) { _ in
            Text("Profile")
        }
    }

}

// MARK: - Preview

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(
                store: Store(
                    initialState: Profile.State(),
                    reducer: Profile.reducer,
                    environment: Profile.Environment()
                )
            )
        }
    }
}
