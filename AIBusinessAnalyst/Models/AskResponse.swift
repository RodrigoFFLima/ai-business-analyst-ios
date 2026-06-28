//
//  AskResponse.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//

import Foundation

struct AskResponse: Codable {
    let question: String
    let metric: String?
    let confidenceScore: Double
    let answer: String

    enum CodingKeys: String, CodingKey {
        case question
        case metric
        case confidenceScore = "confidence_score"
        case answer
    }
}
