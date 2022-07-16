//
//  MainView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {

    let store: Store<Main.State, Main.Action>

    var body: some View {
        WithViewStore(store) { _ in
            Text("Main")
        }
    }

}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MainView(
                store: Store(
                    initialState: Main.State(),
                    reducer: Main.reducer,
                    environment: Main.Environment()
                )
            )
        }
    }
    
}
