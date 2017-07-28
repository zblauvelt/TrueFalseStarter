//
//  Questions.swift
//  TrueFalseStarter
//
//  Created by Zachary Blauvelt on 7/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Trivia {
    private var _question: String!
    private var _answerOne: String!
    private var _answerTwo: String!
    private var _answerThree: String!
    private var _answerFour: String!
    private var _correctAnswer: String!
    
    var question: String {
        return _question
    }
    
    var answerOne: String {
        return _answerOne
    }
    
    var answerTwo: String {
        return _answerTwo
    }
    
    var answerThree: String {
        return _answerThree
    }
    
    var answerFour: String {
        return _answerFour
    }
    
    var correctAnswer: String {
        return _correctAnswer
    }
    
    
    init(question: String, answerOne: String, answerTwo: String, answerThree: String, answerFour: String, correctAnswer: String) {
        self._question = question
        self._answerOne = answerOne
        self._answerTwo = answerTwo
        self._answerThree = answerThree
        self._answerThree = answerFour
        self._correctAnswer = correctAnswer
    }
}


