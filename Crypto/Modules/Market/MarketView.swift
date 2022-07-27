//
//  MarketView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct MarketView: View {

    let store: Store<Market.State, Market.Action>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.currencies, id: \.self) { currency in
                        MarketCell(currency: currency)
                            .listRowInsets(.init(NSDirectionalEdgeInsets.zero))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewStore.send(.openDetails(currency))
                            }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Asset.Colors.corbeau.swiftUIColor)
                }
                .navigationLink(
                    unwrapping: viewStore.binding(\.$selectedCurrencyDetails),
                    destination: { value in
                        CurrencyDetailsView(
                            store: store.scope(
                                state: { _ in value },
                                action: Market.Action.selectedCurrencyDetails
                            )
                        )
                    }
                )

                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .background(
                    Asset.Colors.corbeau.swiftUIColor.edgesIgnoringSafeArea(.all)
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
            .accentColor(Asset.Colors.white.swiftUIColor)
        }
    }

}

// MARK: - Preview

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MarketView(
                store: Store(
                    initialState: Market.State(),
                    reducer: Market.reducer,
                    environment: Market.Environment(
                        currencyService: .mock
                    )
                )
            )
        }
    }
}
