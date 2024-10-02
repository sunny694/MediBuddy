//
//  MBGameSetupVM.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import Foundation

enum MBQuestionDifficulty: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

class MBGameSetupVM {
    var questionValue: Int = 0
    var questionDifficulty = MBQuestionDifficulty.easy
    var numberOfQuestions: Int = 1
    let questionService = MBQuestionService()
    
    var showError: ((String)->())?
    var startGamePlay: ((MBGamePlay)->())?
    
    // GET Questions API
    func getQuestions() {
        questionService.getQuestions(difficulty: questionDifficulty, questionCount: numberOfQuestions) { result in
            switch result {
            case .success(let questions):
                self.startGamePlay?(MBGamePlay(questions: questions))
            case .failure(let error):
                self.showError?(MBUtility.getErrorString(error))
            }
        }
    }
    
    // get question difficulty
    func checkForDifficulty() -> String {
        switch questionValue {
        case 0:
            self.questionDifficulty = .easy
        case 1:
            self.questionDifficulty = .medium
        case 2:
            self.questionDifficulty = .hard
        default:
            self.questionDifficulty = .easy
        }
        return questionDifficulty.rawValue
    }
    
    // MARK: - Logout ** bypassed for now
    func logout(completion: (() -> ())?) {
//        MBAuth.logout(successHandler: { result in
//            switch result {
//            case .success():
//                completion?()
//            case .failure(let error):
//                completion?()
//                self.showError?(MBUtility.getErrorString(error))
//            }
//        })
        // By pass
        completion?()
    }
    
    // // MARK: - Resetting the VM to default
    func reset() {
        questionValue = 0
         questionDifficulty = MBQuestionDifficulty.easy
         numberOfQuestions = 1
    }
    
}
