//
//  HistoryView.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: AskViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.history.isEmpty {
                    emptyState
                } else {
                    historyList
                }
            }
            .navigationTitle("Histórico")
            .toolbar {
                if !viewModel.history.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Limpar") {
                            viewModel.clearHistory()
                        }
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "clock")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text("Nenhuma pergunta ainda")
                .font(.headline)

            Text("As perguntas feitas na Home aparecerão aqui.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    private var historyList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.history) { item in
                    HistoryCard(item: item)
                }
            }
            .padding()
        }
    }
}

struct HistoryCard: View {
    let item: QuestionHistoryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.question)
                .font(.subheadline)
                .fontWeight(.semibold)

            Text(item.answer)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Text(item.metric ?? "Não identificada")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue.opacity(0.12))
                    .clipShape(Capsule())

                Text("\(Int(item.confidenceScore * 100))%")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.green.opacity(0.12))
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    HistoryView(viewModel: AskViewModel())
}
