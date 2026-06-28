//
//  BusinessAnalystService.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//

import Foundation

enum BusinessAnalystServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida."
        case .invalidResponse:
            return "Resposta inválida da API."
        case .serverError(let statusCode):
            return "Erro na API. Status code: \(statusCode)."
        }
    }
}

final class BusinessAnalystService {
    private let baseURL = "http://127.0.0.1:8000"

    func ask(question: String) async throws -> AskResponse {
        guard let url = URL(string: "\(baseURL)/api/ask") else {
            throw BusinessAnalystServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = AskRequest(question: question)
        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw BusinessAnalystServiceError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw BusinessAnalystServiceError.serverError(statusCode: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(AskResponse.self, from: data)
    }
}
