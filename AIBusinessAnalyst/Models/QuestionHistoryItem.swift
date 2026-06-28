//
//  QuestionHistoryItem.swift
//  AIBusinessAnalyst
//
//  Created by Rodrigo Ferrarezi Figueiredo de Lima on 28/06/26.
//

import Foundation

struct QuestionHistoryItem : Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    let metric: String?
    let confidenceScore: Double
}
