//
//  Game.swift
//  FunTrivia
//
//  Created by hackeru on 31/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

// il me reste game et le closeQuestioncontroler
// j'ai deja recuperer mon json jai juste a l'aimplementre de la meme facon que dans le viewcontroller

import Foundation

class Game{
    var score = 0
    
    var question = [Question]()
    var currentIndex = 0
    
    var state: State = .ONGOING
    
    enum State {
        case ONGOING, OVER
    }
    
//    var currentQuestion: Question{
//        return question[currentIndex]
    var currentQuestion: Question?
    
    func refresh(question: Question){
        score = 0
        currentIndex = 0
        state = .OVER
        
        self.currentQuestion = question
        
//        // revenir ici
//        // 1. nom de ma frequence
//        let name = Notification.Name(rawValue: "QuestionLoaded")
//        // 2. create the notification with name
//        let notification = Notification(name: name)
//        // 3. send notification with default
//        NotificationCenter.default.post(notification)
        let questionManager = QuestionManager()
        
        questionManager.loadJson(filename: "closeQuiz")
        print("cocuocu")
        
        
        
        
    }
        
    func answerCurrentQuestion(with answer: Bool) {
//        if (currentQuestion.correct_answers && answer ) || (!currentQuestion.correct_answers && !answer){
            score += 1
//        }
        goToNextQuestion()
    }
    
    func goToNextQuestion(){
        if (currentIndex<question.count - 1){
            currentIndex += 1
        }else{
            finishGame()
        }
    }
    
    func finishGame(){
        state = .OVER
    }
}




