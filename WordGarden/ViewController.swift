//
//  ViewController.swift
//  WordGarden
//
//  Created by Pace Williams on 2/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!
    @IBOutlet weak var wordsBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    
    var wordsToGuess = ["SWIFT","DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    var guessCount = 0
    
    @IBOutlet weak var flowerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = guessedLetterTextField.text!
        guessLetterButton.isEnabled = !(text.isEmpty)
        wordToGuess = wordsToGuess[currentWordIndex]
        wordsBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1)
        updateGameStatusLabels()
    }
    func updateUIAfterGuess() {
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessLetterButton.isEnabled = false
    }
    func formatRevealedWord() {
        var revealedWord = ""
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord += "\(letter) "
            } else {
                revealedWord += "_ "
            }
        }
        revealedWord.removeLast()
        wordsBeingRevealedLabel.text = revealedWord
    }
    
    func updateAfterWinOrLose() {
        // What do we do if the game is over?
        // Increment currentGameIndex by 1
        // disable guessALetterTextField
        // disable guessALetterButton
        // set playAgainButton to .isHidden to false
        // update all labels at top of screen
        currentWordIndex += 1
        guessedLetterTextField.isEnabled = false
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = false
        updateGameStatusLabels()
       
    }
    
    func updateGameStatusLabels() {
        // update labels at top of the screen
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
        wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
        wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)"
    }
    
    func guessALetter() {
        // Get current letters guessed and add it to all lettersGuessed
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        
        // format and show revealedWord in wordBeingRevealedLabel to include new guess
        formatRevealedWord()
        
        // Update image, if needed, and keep track of wrong guesses
        if wordToGuess.contains(currentLetterGuessed) == false {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        // Update gameStatusMessageLabel
        guessCount += 1
        var guesses = "Guesses"
        if guessCount == 1 {
            guesses = "Guess"
        }
        gameStatusMessageLabel.text = "You've made \(guessCount) \(guesses)."
        
        // After each guess, check to see if two things happened:
        // 1. User won the game
        // 2. User lost the game
        
        if wordsBeingRevealedLabel.text!.contains("_") == false {
            gameStatusMessageLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word."
            wordsGuessedCount += 1
            updateAfterWinOrLose()
        } else if wrongGuessesRemaining == 0 {
            gameStatusMessageLabel.text = "So sorry, you're all out of guesses."
            wordsMissedCount += 1
            updateAfterWinOrLose()
        }
        // Check to see if they have played all the words
        if currentWordIndex == wordsToGuess.count {
            gameStatusMessageLabel.text! += "\n\nYou've tried all the words! Restart from the beginning?"
        }
        

        
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces)
        guessLetterButton.isEnabled = !(sender.text!.isEmpty)
        
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        // hide button
        // enable letterGuessedTextField
        // disable guessALetterButton
        // current word should be set to next word
        // set wordBeingRevealed to underscores
        // set wrongGuessesRemaining to maxNumberOfGuesses
        // set guessCount = 0
        // set flowerImageView to flower8
        // clear out lettersGuessed, so new word restarts with no letters guessed
        // reset gameStatusMessage
        if currentWordIndex == wordsToGuess.count {
            currentWordIndex = 0
            wordsGuessedCount = 0
            wordsMissedCount = 0
            
        }
            
        
        
        playAgainButton.isHidden = true
        guessedLetterTextField.isEnabled = true
        guessLetterButton.isEnabled = false
        wordToGuess = wordsToGuess[currentWordIndex]
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        wordsBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1)
        guessCount = 0
        flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuesses)")
        lettersGuessed = ""
        gameStatusMessageLabel.text = "You've Made Zero Guesses."
        
        
        
    }
}

