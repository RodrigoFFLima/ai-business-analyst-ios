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
            response = try await service.ask(question: trimmedQuestion)
        } catch {
            errorMessage = "Não foi possível consultar a API. Verifique se o backend está rodando."
        }

        isLoading = false
    }
}
