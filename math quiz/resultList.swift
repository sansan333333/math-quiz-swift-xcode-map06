//
//  result.swift
//  math quiz
//
//  Created by Jun on 2022-09-29.
//

import UIKit

class result: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = displayResults[indexPath.row]
        cell.textLabel?.text = "Question is: " + result.yourQuestion
        cell.detailTextLabel?.text = "Your answer is: " + result.yourAnswer + "   " + result.rightOrWrong
        return cell
    }
    
    var displayResults: [Result] = []
    var displayScore = Int()
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var yourName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTable.delegate = self
        resultTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        score.text = "Your score is " + String(displayScore)
    }
    
    @IBOutlet weak var resultTable: UITableView!
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped me")
    }
}

