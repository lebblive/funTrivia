//
//  CloseQuestionViewController.swift
//  FunTrivia
//
//  Created by hackeru on 31/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

import UIKit

class CloseQuestionViewController: UIViewController {

    // outlet
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionView: QuestionView!
    
    // vary
    var currentQuestion : Question?
    var questionManager = QuestionManager()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the file
        questionManager.loadJson(filename: "closeQuiz")
        // start game
        updateQuestion(question: questionManager.questions[0])
        // add gesture for the game
        let panGuestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView(_:)))
        
        questionView.addGestureRecognizer(panGuestureRecognizer)
        updateUI()
    }
    
    
    // call on each click
    @IBAction func didTapNewGameButton(){
        updateQuestion(question: questionManager.questions[0])
        score = 0
        scoreLabel.text = ("score\(score)")
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
    }
    
    // what apend on the drag
    @objc func dragQuestionView(_ sender: UIPanGestureRecognizer){
        
        switch sender.state
        {
            //on mooved
        case .began , .changed:
            transformQuestionViewWith(gesture: sender)
            // ended
        case .ended, .cancelled:
            
            let question: Question = self.currentQuestion!
            let answerTrue = "True"
            let answerFalse = "False"
            let isright = true
            // my gesture
            let translation = sender.translation(in: questionView)
            let goodAnswer = question.correct_answers
            
            if ((translation.x > 0) && (goodAnswer.elementsEqual(answerTrue))){
                score += 1
                questionView.style = .correct

            }else if ((translation.x < 0) && (goodAnswer.elementsEqual(answerFalse))){
                score += 1
                questionView.style = .correct

            }else{
                questionView.style = .incorrect
            }

            answerQuestion(with: isright)
            
        default: break
        }
    }
    
    // next question
    func nextQuestion(){
        
        if(questionNumber + 1 < (questionManager.questions.count)){
            questionNumber += 1
            updateQuestion(question: questionManager.questions[questionNumber])
        }else{
            endGame()
        }
    }

    func updateQuestion (question: Question){

        self.currentQuestion = question
        questionView.title = question.question

        updateUI()
    }
    
    func updateUI(){
        scoreLabel.text = "Score: \(score)"
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
    }
    
    func restartQuiz(){
        score = 0
        questionNumber = 0
        updateQuestion(question: questionManager.questions[0])
    }
    
    // give an alert
    func endGame(){
        activityIndicator.isHidden = true
        newGameButton.isHidden = false
        
        let alert = UIAlertController(title: "The End for you", message: "click on restart to play again", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restartQuiz()})
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func transformQuestionViewWith(gesture: UIPanGestureRecognizer){
        
        // get information on the gesture
        let translation = gesture.translation(in: questionView)
        //set her position
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)

        //get the width on screen for addaptation
        let screenWidth = UIScreen.main.bounds.width
        let translationPercent = translation.x/(screenWidth/2)
        
        // turn of just on 30 degre (pi/6)
        let rotationAngle = (CGFloat.pi / 6) * translationPercent
        
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        let transform = translationTransform.concatenating(rotationTransform)
        
        questionView.transform = transform
        
    }
    
    // what append when i answer
    func answerQuestion(with answer : Bool){
        
        // update score
        scoreLabel.text = "\(score) / 10"
        
        // update and translate the screen
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        
        if(questionView.style == .correct){
            translationTransform = CGAffineTransform (translationX: screenWidth, y: 0)
        }else{
            translationTransform = CGAffineTransform (translationX: -screenWidth, y: 0)
        }
        
        // go up to the screen and come back in the midle
        UIView.animate(withDuration: 0.3, animations: {
            self.questionView.transform = translationTransform
        })
        { (success) in if (success){
            self.showQuestionView()
            }
        }
        // get a new question
        nextQuestion()
    }
    
    // show question
    func showQuestionView(){
        questionView.transform = .identity
        questionView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        questionView.style = .standar
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.5, options: [], animations: {self.questionView.transform = .identity}, completion: nil)
    }
    
}
