

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var playerScore : Int = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if (sender.tag == 1){
            pickedAnswer = true
        }
        else if (sender.tag == 2){
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
      
    }
    
    // this method will update all parts of the view on the screen
    func updateUI() {
      progressLabel.text = "\(questionNumber+1)/13"
        scoreLabel.text = "Score: \(playerScore)"
        progressBar.frame.size.width =	(view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    
    // this method will update question text and check if we reached the end
    func nextQuestion() {
       
        if (questionNumber <= 12){
            questionLabel.text = allQuestions.list[questionNumber].questionText
        }
        else {
            
            let alert = UIAlertController (title: "Awesome", message: "You've finished quiz! Ddo you want to start again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        updateUI()
    }
    
    // this method will check if the user has got the right answer
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if (pickedAnswer == correctAnswer){
            ProgressHUD.showSuccess("Correct!")
            playerScore += 10
            
        }
        else
        {
          ProgressHUD.showError("Wrong!")
            
        }
       
       
    }
    
    // this method will wipe the board clean, so that users can retake quiz
    func startOver() {
      questionNumber = 0
      playerScore = 0
      nextQuestion()
      updateUI()
    }
    

    
}
