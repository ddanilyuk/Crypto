//
//  CurrencyDetailsView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct CurrencyDetailsView: View {

    let store: Store<CurrencyDetails.State, CurrencyDetails.Action>

    @Environment(\.presentationMode) private var presentationMode

    private enum Field: Int, CaseIterable {
        case leftPair
        case rightPair
    }
    @FocusState private var focusedField: Field?

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                header
                ScrollView(showsIndicators: false) {
                    CurrencyTextField(
                        text: viewStore.binding(
                            get: { $0.pairLeftString },
                            send: { .setPairLeftSide($0) }
                        ),
                        name: viewStore.currency.symbol
                    )
                        .focused($focusedField, equals: .leftPair)
                        .padding()
                        .keyboardType(.decimalPad)

                    CurrencyTextField(
                        text: viewStore.binding(
                            get: { $0.pairRightString },
                            send: { .setPairRightSide($0) }
                        ),
                        name: "USD"
                    )
                        .focused($focusedField, equals: .rightPair)
                        .padding()
                        .keyboardType(.decimalPad)

                    HStack(spacing: 10) {
                        CurrencyMultiLineButton(
                            title: "Buy \(viewStore.currency.symbol)",
                            subtitle: "\(viewStore.pairRightSide) USD ≈ \(viewStore.pairLeftSide) \(viewStore.currency.symbol)",
                            action: { viewStore.send(.buyButtonTapped) }
                        )
                        CurrencyMultiLineButton(
                            title: "Sell \(viewStore.currency.symbol)",
                            subtitle: "\(viewStore.pairLeftSide) \(viewStore.currency.symbol) ≈ \(viewStore.pairRightSide) USD",
                            action: { viewStore.send(.sellButtonTapped) }
                        )
                    }
                    .padding()

                    about
                        .padding()

                    footer
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") { focusedField = nil }
                    }
                }
            }
            .background(Asset.Colors.corbeau.swiftUIColor.ignoresSafeArea())
            .navigationTitle("\(viewStore.currency.symbol)/USD")
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(
                backgroundColor: Asset.Colors.latinCharm.color,
                titleColor: Asset.Colors.white.color
            )
            .navigationBarItems(
                leading:
                    Asset.Images.Common.backArrow.swiftUI
                    .frame(width: 44, height: 44, alignment: .leading)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }

    private var header: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(viewStore.currency.price.priceString)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(Asset.Colors.white.swiftUIColor)

                Text(viewStore.currency.percentageString)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Asset.Colors.red.swiftUIColor)
                    .padding(.top, 5)

                HStack {
                    VStack(spacing: 7) {
                        Text("24h Low")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)

                        Text(viewStore.currency.min24.priceString)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Asset.Colors.white.swiftUIColor)
                    }

                    Spacer()

                    VStack(spacing: 7) {
                        Text("24h High")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)

                        Text(viewStore.currency.max24.priceString)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Asset.Colors.white.swiftUIColor)

                    }

                    Spacer()

                    VStack(spacing: 7) {

                        Text("Volume (BTC)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)

                        Text(String(viewStore.currency.volume))
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Asset.Colors.white.swiftUIColor)

                    }
                }
                .padding(.top, 25)
                .padding(.bottom, 38)
                .padding(.horizontal, 20)
            }
            .padding(.top, 25)
            .frame(maxWidth: .infinity)
            .background(Asset.Colors.latinCharm.swiftUIColor)
            .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
        }
    }

    private var about: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Text("💸 About")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Asset.Colors.white.swiftUIColor)

                    Spacer()
                }
                Text(viewStore.currency.about)
                    .lineLimit(viewStore.showMore ? .max : 6)
                    .font(.system(size: 14, weight: .regular))
                    .if(viewStore.showMore) { view in
                        view.foregroundColor(Asset.Colors.white.swiftUIColor)
                    }
                    .if(!viewStore.showMore) { view in
                        view.overlayLinearGradient(
                            colors: [
                                Color.white,
                                Color.black.opacity(0.9)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                if !viewStore.showMore {
                    Button(
                        action: { viewStore.send(.binding(.set(\.$showMore, true))) },
                        label: {
                            Text("Show more +")
                                .font(.system(size: 16, weight: .semibold))
                                .overlayLinearGradient(
                                    colors: [
                                        Asset.Colors.strawberryDreams.swiftUIColor,
                                        Asset.Colors.watermelonJuice.swiftUIColor
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                        }
                    )
                }
            }
        }
    }

    var grad: some View {
        EmptyView()
            .overlayLinearGradient(
                colors: [
                    Asset.Colors.white.swiftUIColor,
                    Asset.Colors.white.swiftUIColor.opacity(0.01)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
    }

    private var footer: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 12) {
                HStack {
                    Text("Rank")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Asset.Colors.white.swiftUIColor)

                    Spacer()

                    Text("№ \(viewStore.currency.rank)")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                }
                .padding()
                .background(Asset.Colors.latinCharm.swiftUIColor)
                .cornerRadius(12)
                
                HStack {
                    Text("Launch Date")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Asset.Colors.white.swiftUIColor)

                    Spacer()

                    Text(viewStore.currency.launchDate, format: .dateTime.day().month().year())
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Asset.Colors.heatherGrey.swiftUIColor)
                }
                .padding()
                .background(Asset.Colors.latinCharm.swiftUIColor)
                .cornerRadius(12)
            }
        }
    }

}

// MARK: - Preview

struct CurrencyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrencyDetailsView(
                store: Store(
                    initialState: CurrencyDetails.State(currency: .allMock1),
                    reducer: CurrencyDetails.reducer,
                    environment: CurrencyDetails.Environment()
                )
            )
        }
    }
}
