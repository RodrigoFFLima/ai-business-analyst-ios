//
//  AskView.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//
import SwiftUI

struct AskView: View {
    @ObservedObject var viewModel: AskViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection

                    questionSection

                    suggestedQuestionsSection

                    askButton

                    if let errorMessage = viewModel.errorMessage {
                        errorSection(errorMessage)
                    }

                    if let response = viewModel.response {
                        responseSection(response)
                    }
                }
                .padding()
            }
            .navigationTitle("AI Business Analyst")
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Faça uma pergunta de negócio")
                .font(.title2)
                .fontWeight(.bold)

            Text("O app consulta o backend Python/FastAPI e usa uma camada semântica para identificar a métrica correta.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var questionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pergunta")
                .font(.headline)

            TextField("Ex: Qual foi a receita total?", text: $viewModel.question)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.sentences)
                .submitLabel(.send)
                .onSubmit {
                    Task {
                        await viewModel.ask()
                    }
                }
        }
    }

    private var suggestedQuestionsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Perguntas sugeridas")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.suggestedQuestions, id: \.self) { suggestedQuestion in
                        Button {
                            Task {
                                await viewModel.askSuggestedQuestion(suggestedQuestion)
                            }
                        } label: {
                            Text(suggestedQuestion)
                                .font(.subheadline)
                                .lineLimit(1)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }

    private var askButton: some View {
        Button {
            Task {
                await viewModel.ask()
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Perguntar")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.isLoading)
    }

    private func errorSection(_ message: String) -> some View {
        Text(message)
            .foregroundStyle(.red)
            .font(.subheadline)
    }

    private func responseSection(_ response: AskResponse) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            InfoCard(
                title: "Resposta",
                value: response.answer
            )

            InfoCard(
                title: "Métrica identificada",
                value: response.metric ?? "Não identificada"
            )

            InfoCard(
                title: "Confiança",
                value: "\(Int(response.confidenceScore * 100))%"
            )
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    AskView(viewModel: AskViewModel())
}
