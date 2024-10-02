//
//  MBGame.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//

import Foundation

// MARK: - Data Model for Game
struct MBGame: Codable {
    let responseCode: Int
    let results: [MBQuestion]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Questions
struct MBQuestion: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    
}
