//
//  MBGamePageVM.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import Foundation

class MBGamePageVM {
    // MARK: - Game page
    var gamePlay:MBGamePlay
    private var questionCounter: Int = 0 {
        didSet {
            // MARK: - Observer when
            if questionCounter == gamePlay.questions.count {
                // handle last question closure
                self.handleLastQuestion?()
            }
        }
    }
    
    //
    var handleLastQuestion: (() -> Void)?
    
    init(gamePlay: MBGamePlay) {
        self.gamePlay = gamePlay
    }
    
    // // MARK: - Get next question
    func getQuestion() -> MBQuestion? {
        if questionCounter < gamePlay.questions.count {
            questionCounter += 1
            return gamePlay.questions[questionCounter - 1]
        }
        return nil
    }
    
}
