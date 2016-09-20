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
        setupGameTitleLabel()
    }

    var gameTitleLabel: UILabel?

    func setupGameTitleLabel() {
        let frame = CGRect(x: 100, y: 70, width: 200, height: 30)
        gameTitleLabel = UILabel(frame: frame)
        view.addSubview(gameTitleLabel!)
    }

    func resetGameState() {
        ticTacToeState.removeAll()
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
        isPlayerOne = true
        resetAllButtons(color: true, shouldEnableButton: true)
        resetGameState()
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
        var winnerName: String?
        if let winner = checkAllRowWinner() {
            if winner == .PlayerOne {
                winnerName = "Winner: Player One"
            } else {
                winnerName = "Winner: Player Two"
            }
        }
        // 2) 3 of the same item in the same col
        if let winner = checkAllColWinner() {
            if winner == .PlayerOne {
                winnerName = "Winner: Player One"
            } else {
                winnerName = "Winner: Player Two"
            }
        }
        // 3) 3 of the same item in diagonal
        if let winner = checkAllDiagonalWinner() {
            if winner == .PlayerOne {
                winnerName = "Winner: Player One"
            } else {
                winnerName = "Winner: Player Two"
            }
        }
        if let player = winnerName {
            gameTitleLabel?.text = player
            resetAllButtons(color: false, shouldEnableButton: false)
        }
    }

    func checkAllRowWinner() -> State? {
        for row in 0..<3 {
            var rowStates = [State]()
            for col in 0..<3 {
                if ticTacToeState[row][col] == .PlayerOne {
                    rowStates.append(.PlayerOne)
                } else if ticTacToeState[row][col] == .PlayerTwo {
                    rowStates.append(.PlayerTwo)
                } else {
                    rowStates.append(.Empty)
                }
            }
            guard let playerWinner = checkArrWinner(rowStates) else { continue }
            return playerWinner
        }
        return nil
    }

    func checkArrWinner(arr: [State]) -> State? {
        let winnerArray = Array(Set(arr))
        if winnerArray.count == 1 {
            if winnerArray.first == .PlayerOne {
                return .PlayerOne
            } else if winnerArray.first == .PlayerTwo {
                return .PlayerTwo
            } else {
                return nil
            }
        }
        return nil
    }


    func checkAllColWinner() -> State? {
        for col in 0..<3 {
            var colStates = [State]()
            for row in 0..<3 {
                if ticTacToeState[row][col] == .PlayerOne {
                    colStates.append(.PlayerOne)
                } else if ticTacToeState[row][col] == . PlayerTwo {
                    colStates.append(.PlayerTwo)
                } else {
                    colStates.append(.Empty)
                }
            }
            guard let colWinner = checkArrWinner(colStates) else { continue }
            return colWinner
        }
        return nil
    }

    func checkAllDiagonalWinner() -> State? {
        var fowardDiagonalWinner = [State]()
        for row in 0..<3 {
            for col in 0..<3 {
                if row == col {
                    fowardDiagonalWinner.append(ticTacToeState[row][col])
                }
            }
        }

        let fdw = Array(Set(fowardDiagonalWinner))
        if fdw.count == 1 && fdw.first != .Empty {
            return fdw.first
        }

        var backWardDiagonalWinner = [State]()
        for row in 0..<3 {
            for col in (0..<3).reverse() {
                if row + col == 2 {
                    backWardDiagonalWinner.append(ticTacToeState[row][col])
                }
            }
        }
        let bdw = Array(Set(backWardDiagonalWinner))
        if bdw.count == 1 && bdw.first != .Empty {
            return bdw.first
        }

        return nil

    }

}

