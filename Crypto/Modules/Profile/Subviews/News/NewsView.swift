//
//  NewsView.swift
//  Crypto
//
//  Created by Denys Danyliuk on 17.07.2022.
//

import SwiftUI
import ComposableArchitecture

struct NewsView: View {

    struct ViewState: Equatable {
        let news: [Article]
    }

    enum ViewAction {
        case openArticle(Article)
        case showAll
    }

    @ObservedObject var viewStore: ViewStore<ViewState, ViewAction>

    var body: some View {
        VStack(spacing: 0) {
            header
            list
        }
    }

    private var header: some View {
        HStack {
            Text("🪙 News")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Asset.Colors.white.swiftUIColor)

            Spacer()

            Button(
                action: { viewStore.send(.showAll) },
                label: {
                    Text("Show all")
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
        .padding(.horizontal, 20)
        .padding(.top, 43)
        .padding(.bottom, 26)
    }

    private var list: some View {
        LazyVStack {
            ForEach(viewStore.news) { item in
                NewsRow(news: item)
                    .onTapGesture {
                        viewStore.send(.openArticle(item))
                    }
            }
        }
        .padding(.bottom, 22)
    }
}

// MARK: - ViewState

extension Profile.State {

    var newsView: NewsView.ViewState {
        NewsView.ViewState(
            news: news
        )
    }

}

// MARK: - ViewAction

extension Profile.Action {

    static func newsView(_ viewAction: NewsView.ViewAction) -> Self {
        switch viewAction {
        case .showAll:
            return .showAllNews

        case let .openArticle(article):
            return .openArticle(article)
        }
    }

}
