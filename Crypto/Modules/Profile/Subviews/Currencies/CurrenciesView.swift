//
//  CurrenciesHorizontalView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct CurrenciesView: View {

    struct ViewState: Equatable {
        let currencies: [Currency]
    }

    enum ViewAction {
        case openCurrencyDetails(Currency)
    }

    @ObservedObject var viewStore: ViewStore<ViewState, ViewAction>

    var body: some View {
        VStack {
            header
            collection
        }
    }

    private var header: some View {
        HStack {
            Text("🔥 Trending")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Asset.Colors.white.swiftUIColor)
            Spacer()
        }
        .padding(.leading, 16)
    }

    private var collection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                // TODO: ForEachStore?
                ForEach(viewStore.currencies) { currency in
                    CurrencyCell(currency: currency)
                        .onTapGesture {
                            viewStore.send(.openCurrencyDetails(currency))
                        }
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
    
}


// MARK: - ViewState

extension Profile.State {

    var currenciesView: CurrenciesView.ViewState {
        CurrenciesView.ViewState(
            currencies: trendingCurrencies
        )
    }

}

// MARK: - ViewAction

extension Profile.Action {

    static func currenciesView(_ viewAction: CurrenciesView.ViewAction) -> Self {
        switch viewAction {
        case let .openCurrencyDetails(currency):
            return .openCurrencyDetails(currency)
        }
    }

}
