//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit


var alphabet = ["Space ", "A","B","C", "D", "E", "F", "G", "H", "I",
                "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
                "V","W", "X", "Y", "Z"]
var copy1 = ["Space", "A","B","C", "D", "E", "F", "G", "H", "I",
    "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
    "V","W", "X", "Y", "Z"]
var image = 1


class HangmanViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var hangmanState: UIImageView!
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBAction func newGameClicked(sender: UIButton) {
        newGame()
    }
    @IBAction func guessClicked(sender: UIButton!) {
        guess()
    }
    var hangman = Hangman()
    var correctAnswer = []
    override func viewDidLoad() {
        newGame()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alphabet.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return alphabet[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if alphabet[row] == "Space" {
            guessLabel.text = " "
        } else {
            guessLabel.text = alphabet[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(alphabet.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let titleData = alphabet[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }
    
    func newGame() {
        hangmanState.image = UIImage(named: "Hangman1.png")
        hangman.start()
        correctAnswer = hangman.answer!.characters.map { String($0) }
        alphabet = copy1
        image = 1
    }
    
    func guess() {
        let correct = hangman.guessLetter(guessLabel.text!)
        alphabet = alphabet.filter() {$0 != guessLabel.text!}
        if !correct {
            image += 1
            if (image > 6) {
                let alert = UIAlertView()
                alert.title = "Game Over!"
                alert.message = "Sorry Try Again! The correct word was \(hangman.answer!)"
                alert.addButtonWithTitle("Awww")
                alert.show()
            }
            hangmanState.image = UIImage(named: "Hangman\(image).png")
        } else if correct {
            correctAnswer = correctAnswer.filter() {$0 as! String != guessLabel.text!}
            if (correctAnswer.count == 0) {
                let alert = UIAlertView()
                alert.title = "Congrats"
                alert.message = "You win! Press New Game to Play Again"
                alert.addButtonWithTitle("Yay!")
                alert.show()
            }
            let alert = UIAlertView()
            alert.title = "Correct"
            alert.message = "You have \(correctAnswer.count) letters remaining!"
            alert.addButtonWithTitle("Keep Going!")
            alert.show()
        }
    }
    
    
    
    
}

