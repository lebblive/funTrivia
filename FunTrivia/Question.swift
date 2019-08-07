//
//  Question.swift
//  FunTrivia
//
//  Created by kevin vidal on 26/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let incorrect_answers: [String]
    let correct_answers: String
    
    init(questionText: String,
         incorrect_answers: [String],
         correct_answers: String)
    {
        self.question = questionText
        self.incorrect_answers = incorrect_answers
        self.correct_answers = correct_answers
    }
}
