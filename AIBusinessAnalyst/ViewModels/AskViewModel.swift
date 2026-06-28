//
//  AskViewModel.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//
import Foundation
import Combine

@MainActor
final class AskViewModel: ObservableObject {
    @Published var question: String = ""
    @Published var response: AskResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var history: [QuestionHistoryItem] = []

    let suggestedQuestions: [String] = [
        "Qual foi a receita total?",
        "Quantos pedidos tivemos?",
        "Qual foi o ticket médio?",
        "Qual foi o produto mais vendido?"
    ]

    private let service = BusinessAnalystService()

    func ask() async {
        let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmedQuestion.count >= 3 else {
            errorMessage = "Digite uma pergunta com pelo menos 3 caracteres."
            return
        }

        isLoading = true
        errorMessage = nil
        response = nil

        do {
            let apiResponse = try await service.ask(question: trimmedQuestion)
            response = apiResponse

            let historyItem = QuestionHistoryItem(
                question: apiResponse.question,
                answer: apiResponse.answer,
                metric: apiResponse.metric,
                confidenceScore: apiResponse.confidenceScore
            )

            history.insert(historyItem, at: 0)
        } catch {
            errorMessage = "Não foi possível consultar a API. Verifique se o backend está rodando."
        }

        isLoading = false
    }

    func askSuggestedQuestion(_ suggestedQuestion: String) async {
        question = suggestedQuestion
        await ask()
    }

    func clearHistory() {
        history.removeAll()
    }
}
