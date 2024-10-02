//
//  MBGameService.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import Foundation

class MBGamePlay {
    var questions: [MBQuestion]
    // temperory --- change
    var answers: [Bool] = []
    var attemptedQuestions: Int = 0
    var correctAnswers: Int = 0
    var isPlayingAgain: Bool = false
    
    init(questions: [MBQuestion]) {
        self.questions = questions
    }
    
    // reset for play again.
    func reset() {
        answers = []
        correctAnswers = 0
        attemptedQuestions = 0
        answers.removeAll()
    }
    
    // get accuracy of game play.
    func getAccuracy() -> Int {
        return Int((Float(correctAnswers) / Float(questions.count))*Float(100))
    }
}


/// A service responsible for fetching questions from an API based on specified difficulty and question count.
struct MBQuestionService {
    /**
     Fetches a list of questions based on the specified difficulty and question count.
     
     - Parameters:
     - difficulty: The difficulty level of the questions to be fetched (e.g., easy, medium, hard).
     - questionCount: The number of questions to fetch.
     - completion: A closure that gets called when the operation is complete. It provides either a success with an array of `MBQuestion` objects, or a failure with an `APIError`.
     
     */
    func getQuestions(difficulty: MBQuestionDifficulty, questionCount: Int, completion: @escaping (Result<[MBQuestion], APIError>) -> Void) {
        let queryParams = queryParams(difficulty: difficulty, questionCount: questionCount)
        MBAPIManager.shared.request(url: MBAPI.getQuestions, httpMethod: .GET, queryParams: queryParams) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(MBGame.self, from: data)
                    if !response.results.isEmpty {
                        completion(.success(response.results))
                    } else {
                        completion(.success([]))
                    }
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /**
     Constructs the query parameters for the API request.
     - Parameters:
     - difficulty: The difficulty level for the questions (e.g., easy, medium, hard).
     - questionCount: The number of questions to fetch.
     
     - Returns: A dictionary containing the query parameters for the request.
     */
    private func queryParams(difficulty: MBQuestionDifficulty, questionCount: Int) -> [String: String]? {
        return ["difficulty": difficulty.rawValue, "amount": String(questionCount)]
    }
}


