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

    var ticTacToeState = [[State]]()

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
        resetGameState()
    }

    func resetGameState() {
        for _ in 0..<3 {
            let row = Array(count: 3, repeatedValue: State.Empty)
            ticTacToeState.append(row)
        }

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
        resetAllButtons()
    }

    func resetAllButtons() {
        for v in view.subviews {
            if let button = v as? UIButton {
                if let title = button.currentTitle {
                    if title != resetButtonName {
                        button.backgroundColor = .blueColor()
                        button.enabled = true
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
        print("isPlayerOne = \(isPlayerOne)")
        // we want to disable the button once it's tapped... prevent cheaters
        button.enabled = false
        // isPlayerOne is always true for initial state... once button is tapped the boolean value of isPlayerOne will alternate.
        guard let title = button.currentTitle else { return }
        let indexValue = convertStringToTupleFrom(title)
        if isPlayerOne {
            ticTacToeState[indexValue.0][indexValue.1] = .PlayerOne
            button.backgroundColor = .redColor()
            isPlayerOne = false
        } else {
            ticTacToeState[indexValue.0][indexValue.1] = .PlayerTwo
            button.backgroundColor = .greenColor()
            isPlayerOne = true
        }
        // b4 we check for winner.... we need to set the player value in the ticTacToeState

        checkForWinner()
    }

    func convertStringToTupleFrom(title: String) -> (Int, Int) {
        let numbers = title.componentsSeparatedByString(",")
        let tuple = (Int(numbers[0])!, Int(numbers[1])!)
        return tuple
    }


    func checkForWinner() {
        // possible way of winning the game
        // 1) 3 of the same item in the same row
        checkAllRowWinner()
        // 2) 3 of the same item in the same col
        checkAllColWinner()
        // 3) 3 of the same item in diagonal
        checkAllDiagonalWinner()

    }

    func checkAllRowWinner() {

    }

    func checkAllColWinner() {

    }

    func checkAllDiagonalWinner() {

    }

}

