//
//  MBQuestionVM.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import Foundation

class MBQuestionVM {
    var questionObj: MBQuestion
    var options:[String]
    let question:String
    let correctAnswer:String
    var didAnswerQuestion:Bool = false
    
    init(questionObj: MBQuestion) {
        self.questionObj = questionObj
        self.options = questionObj.incorrectAnswers + [questionObj.correctAnswer]
        self.options.shuffle()
        self.question = questionObj.question
        self.correctAnswer = questionObj.correctAnswer
    }
    
    // Check for valid answer
    func isValidAnswer(with selectedIndex:Int) -> Bool {
        return selectedIndex == getAnswerIndexPath() ? true : false
    }
    
    // get Correct answer index
    func getAnswerIndexPath() -> Int? {
        return options.firstIndex(of: correctAnswer) 
    }
    
}
