//
//  ViewController.swift
//  math quiz
//
//  Created by Jun on 2022-09-28.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var generateButton: UIButton!
    
    @IBAction func clearButton(_ sender: Any) {
        question.text = ""
        answer.text = ""
        result.isHidden = true
    }
    
    @IBAction func numberBtn(_ sender: UIButton) {
        //        answer.text = answer.text! + String(sender.tag)
        answer.text! += "\(sender.tag)"
    }
    
    var hasDot = false
    
    var results: [Result] = []
    
    var numberFromScreen: Int {
        get {
            return Int(answer.text!)!
        }
        set {
            answer.text = "\(newValue)"
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        
        if !hasDot {
            answer.text = answer.text! + "."
            hasDot = true
        }else if !hasDot {
            answer.text = "0."
        }
    }
    
    @IBAction func minus(_ sender: Any) {
        numberFromScreen = -numberFromScreen
    }
    
    enum Operation: String, CaseIterable{
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case null = "null"
    }
    
    var num1 = 0
    var num2 = 0
    //    var randomOperators = Operation.allCases.randomElement()!
    var answerNum1Num2 = 0
    var score = 0
    var operatpor = ""
    
    func startGame () {
        print(answerNum1Num2)
        
        answer.text = ""
        result.isHidden = true
        
        var num1 = Int.random(in: 0..<10)
        var num2 = Int.random(in: 0..<10)
        let randonMath1to4 = Int.random(in: 1..<5)
        
        switch randonMath1to4 {
        case 1:
            operatpor = "+"
            answerNum1Num2 = num1 + num2
            question.text = "\(num1) \(operatpor) \(num2)"
            break
        case 2:
            operatpor = "-"
            answerNum1Num2 = num1 - num2
            question.text = "\(num1) \(operatpor) \(num2)"
            break
        case 3:
            operatpor = "*"
            answerNum1Num2 = num1 * num2
            question.text = "\(num1) \(operatpor) \(num2)"
            break
        case 4:
            operatpor = "/"
            while true {
                if num2 == 0 {
                    num1 = Int.random(in: 0..<10)
                    num2 = Int.random(in: 0..<10)
                } else {
                    break
                }
            }
            answerNum1Num2 = num1 / num2
        default: break
        }
        question.text = "\(num1) \(operatpor) \(num2)"
        print(answerNum1Num2)
    }
    
    
    @IBAction func nextGame(_ sender: Any) {
        startGame()
    }
    
    @IBAction func vaildationButton(_ sender: Any) {
        
        if Int(answer.text!) == answerNum1Num2 {
            result.isHidden = false
            result.text = " Correct answer! ✌🏻 / answer is \(answerNum1Num2)"
            score += 1
        }else{
            result.isHidden = false
            result.text = " Wrong answer! 😱 / answer is \(answerNum1Num2)"
            score -= 1
        }
        
        let yourQuestion = question.text ?? ""
        let yourAnswer = answer.text ?? ""
        let rightOrWrong = result.text ?? ""
        
        let resultList = Result (yourQuestion: yourQuestion,
                                 yourAnswer: yourAnswer,
                                 rightOrWrong: rightOrWrong)
        results.append(resultList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultPage" {
            let resultVC = segue.destination as! result
            resultVC.displayResults = results
            resultVC.displayScore = score
        }
    }
    
    @IBAction func unwindFinishGame (_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "fromResultShow" {
            let vc = unwindSegue.source as! result
            result.text =  vc.yourName.text! + "\n " + vc.score.text!
            question.text = ""
        }
    }
}
