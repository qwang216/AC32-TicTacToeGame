//
//  ViewController.swift
//  TicTacGame
//
//  Created by Jason Wang on 9/20/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class GameBoardController: UIViewController {

    var isPlayerOne = true

    let game = TicTacToe()
    enum State {
        case Empty
        case PlayerOne
        case PlayerTwo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        setupGameBoard()
    }

    func setupGameBoard() {
        // setup 3 by 3 buttons
        for row in 0..<3 {
            for col in 0..<3 {
                //we construct the button base on row and col value
                constructButtonAt(row, col: col)
            }
        }
        setupResetButton()
        game.resetGameState()
        setupGameTitleLabel()
    }

    var gameTitleLabel: UILabel?

    func setupGameTitleLabel() {
        let frame = CGRect(x: 100, y: 70, width: 200, height: 30)
        gameTitleLabel = UILabel(frame: frame)
        view.addSubview(gameTitleLabel!)
    }

    let resetButtonName = "Reset Game"

    func setupResetButton() {
        let frame = CGRect(x: 130, y: 450, width: 120, height: 90)
        let resetButton = UIButton(frame: frame)
        resetButton.setTitle(resetButtonName, forState: .Normal)
        resetButton.backgroundColor = .blueColor()
        resetButton.addTarget(self, action: #selector(handleResetButton), forControlEvents: .TouchUpInside)
        view.addSubview(resetButton)
    }

    func handleResetButton(resetButton: UIButton) {
        // reset all the colors... let's make a function that reset all the button colors to blue except the resetbutton itself
        isPlayerOne = true
        resetAllButtons(color: true, shouldEnableButton: true)
        game.resetGameState()
        gameTitleLabel?.text = "Let's Play!!!"
    }

    func resetAllButtons(color resetColor: Bool, shouldEnableButton: Bool) {
        for v in view.subviews {
            if let button = v as? UIButton {
                if let title = button.currentTitle {
                    if title != resetButtonName {
                        if resetColor {
                            button.backgroundColor = .blueColor()
                        }
                        button.enabled = shouldEnableButton
                    }
                }
            }
        }
    }



    func constructButtonAt(row: Int, col: Int) {
        // we mulitiply by 90 to prevent buttons from overlapping
        // we add 60 and 150 to make all our buttons to be in the center of the screen
        let xValue = (col * 90) + 60
        let yValue = (row * 90) + 150
        let frame = CGRect(x: xValue, y: yValue, width: 80, height: 80)

        // construct the button with frame
        let button = UIButton(frame: frame)
        // set the background color to blue as an initial state
        button.backgroundColor = .blueColor()
        // set the title to a blank string and state to normal
        let title = "\(row),\(col)"
        button.setTitle(title, forState: .Normal)
        // attach an action function call "handleButtonTapped"
        button.addTarget(self, action: #selector(handleButtonTapped), forControlEvents: .TouchUpInside)
        // once we finished constructing the button we add the button to the view
        view.addSubview(button)
    }

    func handleButtonTapped(button: UIButton) {
        // we want to disable the button once it's tapped... prevent cheaters
        button.enabled = false
        // isPlayerOne is always true for initial state... once button is tapped the boolean value of isPlayerOne will alternate.
        guard let title = button.currentTitle else { return }
        let indexValue = game.convertStringToTupleFrom(title)
        if isPlayerOne {
            game.setPlayerMarkOn(indexValue)
            button.backgroundColor = .redColor()
            isPlayerOne = false
        } else {
            game.setPlayerMarkOn(indexValue)
            button.backgroundColor = .greenColor()
            isPlayerOne = true
        }
        // b4 we check for winner.... we need to set the player value in the ticTacToeState

        if let playerName = game.checkForWinner() {
            gameTitleLabel?.text = playerName
            resetAllButtons(color: false, shouldEnableButton: false)
        }
    }

}

