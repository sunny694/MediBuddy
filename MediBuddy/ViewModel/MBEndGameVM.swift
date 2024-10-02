//
//  MBEndGameVM.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import Foundation

class MBEndGameVM {
    // MARK: - End game view model for end game stats
    var gamePlay:MBGamePlay

    init(gamePlay: MBGamePlay) {
        self.gamePlay = gamePlay
    }
    
    func playAgain() {
        gamePlay.isPlayingAgain = true
        gamePlay.reset()
    }
    
    func getAccuracy() -> String {
        return "\(gamePlay.getAccuracy())%"
    }
    
    func getDifficulty() -> String {
        return gamePlay.questions.first?.difficulty ?? MBQuestionDifficulty.easy.rawValue
    }
    
    func correctAttempts() -> String {
        return "\(gamePlay.correctAnswers)"
    }
    
    func wrongAttempts() -> String {
        return "\(gamePlay.questions.count - gamePlay.correctAnswers)"
    }
}
