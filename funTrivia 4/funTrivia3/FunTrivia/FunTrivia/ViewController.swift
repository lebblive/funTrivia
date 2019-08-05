//
//  ViewController.swift
//  FunTrivia
//
//  Created by kevin vidal on 26/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // the up
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // questions
    @IBOutlet weak var answersStackView: UIStackView!
    
    
    // vary
    
    var currentQuestion : Question?
    
    var questionManager = QuestionManager()
    
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionManager.loadJson(filename: "trivia")
        
        updateQuestion(question: questionManager.questions[0])
        
        print(currentQuestion!.question)
        updateUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // round my question view
    private func roundButton(){
        questionLabel.layer.cornerRadius = 12
        questionLabel.layer.masksToBounds = true
    }
    
    // create buton with number of response
    
    private func createButton(with text : String){
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        button.addTarget(self, action: #selector(answerPressed(_:)), for: .touchUpInside)
        answersStackView.addArrangedSubview(button)
    }
    

    // onclick
    @objc func answerPressed(_ sender: UIButton) {
        
        //the current click
        let  getOnclickText : String = sender.currentTitle!
        // je cherche a savoir sur qoi j'apui
        

        
        // the correct Answer
        let correctAnswer: String = currentQuestion!.correct_answers
        
        if (getOnclickText.elementsEqual(correctAnswer)){
            
            score += 1
            sender.backgroundColor = UIColor.green
            
        }else{
            
            sender.backgroundColor = UIColor.red
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.nextQuestion()
        }
    }
    
    func nextQuestion(){
        if questionNumber + 1 < questionManager.questions.count
        {
            questionNumber += 1
            updateQuestion(question: questionManager.questions[questionNumber])
        }else{
            endGame()
        }
    }
    
    func updateQuestion(question: Question){

        answersStackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }
        
        self.currentQuestion = question
        questionLabel.text = question.question
        let allQuestion = [question.correct_answers] + question.incorrect_answers

        for ans in allQuestion.shuffled(){
            createButton(with: ans)
        }
        
        updateUI()
    }
    
    /*
     look me the score , numberQuestion and up the progresse bar
     */
    func updateUI(){
        scoreLabel.text = "Score: \(score)"
        questionCounter.text = "\(questionNumber)/\(questionManager.questions.count)"
        // progresse bar
        progressView.frame.size.width = (view.frame.size.width / CGFloat(questionManager.questions.count)) * CGFloat(questionNumber + 1)
    }
    
    // restart
    func restartQuiz(){
        score = 0
        questionNumber = 0
        updateQuestion(question: questionManager.questions[0])
    }
    
    // give me an alert
    func endGame(){
        
        let alert = UIAlertController(title: "The End for you", message: "click on restart to play again", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restartQuiz()})
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
}

