//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var usedQuestions = [Trivia]()
    var previousNumber = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }
    
    func displayQuestion() {
        
        func randomNumber() -> Int {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
            print("ZACK: Orginal random number is \(indexOfSelectedQuestion)")
            while previousNumber == indexOfSelectedQuestion {
                indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
                print("ZACK: New random number in while loop is \(indexOfSelectedQuestion)")
            }
            previousNumber = indexOfSelectedQuestion
            print("ZACK: Previous number is \(previousNumber)")
            print("ZACK: The final index number is \(indexOfSelectedQuestion)")
            return indexOfSelectedQuestion
        }
        indexOfSelectedQuestion = randomNumber()
        
        questionField.text = trivia[indexOfSelectedQuestion].question
        answerOne.setTitle(trivia[indexOfSelectedQuestion].answerOne, for: .normal)
        answerTwo.setTitle(trivia[indexOfSelectedQuestion].answerTwo, for: .normal)
        answerThree.setTitle(trivia[indexOfSelectedQuestion].answerThree, for: .normal)
        answerFour.setTitle(trivia[indexOfSelectedQuestion].answerFour, for: .normal)
        playAgainButton.isHidden = true

    }
    
    func displayScore() {
        // Hide the answer buttons
        answerOne.isHidden = true
        answerTwo.isHidden = true
        answerThree.isHidden = true
        answerFour.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        switch sender {
        case answerOne:
            btnPressedCheck(button: buttonOne)
        case answerTwo:
            btnPressedCheck(button: buttonTwo)
        case answerThree:
            btnPressedCheck(button: buttonThree)
        case answerFour:
            btnPressedCheck(button: buttonFour)
        default:
            questionField.text = "Sorry, wrong answer!"
            
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        answerOne.isHidden = false
        answerTwo.isHidden = false
        answerThree.isHidden = false
        answerFour.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func btnPressedCheck (button: String) {
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = trivia[indexOfSelectedQuestion].correctAnswer
        if correctAnswer == button {
            correctQuestions += 1
            questionField.text = "Correct!"
        }else {
            questionField.text = "Sorry, wrong answer!"
        }
    }
}

