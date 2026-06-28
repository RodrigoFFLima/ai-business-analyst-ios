//
//  MainTabView.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = AskViewModel()

    var body: some View {
        TabView {
            AskView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("Histórico", systemImage: "clock.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
