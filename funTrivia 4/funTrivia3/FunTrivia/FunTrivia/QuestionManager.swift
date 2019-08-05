//
//  QuestionManager.swift
//  FunTrivia
//
//  Created by hackeru on 28/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

import Foundation

class QuestionManager{
    //j'essaie de rajouter un singleton
//    static let shared = QuestionManager()
//    init(){}
    var questions : [Question] = []
    
    struct ResponseData: Decodable {
        var results: [Result]
        
        var questions : [Question]{
           
            return results.compactMap{ $0.toQuestion }
            
        }
    }
    
    struct Result: Decodable {
        var question: String
        var correct_answer: String
        var incorrect_answers : [String]
        var toQuestion : Question{
            return Question(questionText: question,
                            incorrect_answers: incorrect_answers,
                            correct_answers: correct_answer)
        }
    }
   
    func loadJson(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json")
            else{return}

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // retransmet mon json en objet:
            //
            let jsonData = try decoder.decode(ResponseData.self,from: data)
            self.questions = jsonData.questions
        }catch{
            print("error\(error)")
            return
        }
    }


}




