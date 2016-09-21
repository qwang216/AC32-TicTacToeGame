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
    let resetGameTitleName = "Player1: Red  |  Player2: Green"

    var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        return label
    }()

    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        setupGameBoard()
    }

    func setupGameBoard() {
        // setup nav bar title
        navigationItem.title = "TicTacToe Game"

        setupContainerView()
        setupGameTitleLabel()
        setupResetButton()
        game.resetGameState()
        // setup 3 by 3 buttons
        for row in 0..<3 {
            for col in 0..<3 {
                //we construct the button base on row and col value
                constructButtonAt(row, col: col)
            }
        }

    }

    func setupContainerView() {
        view.addSubview(containerView)
        containerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        containerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 10).active = true
        containerView.heightAnchor.constraintEqualToConstant(320).active = true
        containerView.widthAnchor.constraintEqualToConstant(260).active = true
    }

    func setupGameTitleLabel() {
        view.addSubview(gameTitleLabel)
        gameTitleLabel.text = resetGameTitleName
        gameTitleLabel.bottomAnchor.constraintEqualToAnchor(containerView.topAnchor, constant: -10).active = true
        gameTitleLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        gameTitleLabel.heightAnchor.constraintEqualToConstant(20).active = true
        gameTitleLabel.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 20).active = true
        gameTitleLabel.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -20).active = true
    }

    let resetButtonName = "Reset Game"
    let resetButton: UIButton = {
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setupResetButton() {
        containerView.addSubview(resetButton)
        resetButton.setTitle(resetButtonName, forState: .Normal)
        resetButton.setTitleColor(.whiteColor(), forState: .Normal)
        resetButton.backgroundColor = .blueColor()
        resetButton.addTarget(self, action: #selector(handleResetButton), forControlEvents: .TouchUpInside)

        resetButton.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
        resetButton.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        resetButton.heightAnchor.constraintEqualToConstant(50).active = true
        resetButton.widthAnchor.constraintEqualToConstant(100).active = true
    }

    func handleResetButton(resetButton: UIButton) {
        // reset all the colors... let's make a function that reset all the button colors to blue except the resetbutton itself
        isPlayerOne = true
        resetAllButtons(shouldResetButtonColor: true, shouldEnableButton: true)
        game.resetGameState()
        gameTitleLabel.text = resetGameTitleName
    }

    func resetAllButtons(shouldResetButtonColor resetColor: Bool, shouldEnableButton: Bool) {
        for v in containerView.subviews {
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
        let xValue = (col * 90)
        let yValue = (row * 90)
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
        containerView.addSubview(button)
    }

    func handleButtonTapped(button: UIButton) {
        // we want to disable the button once it's tapped... prevent cheaters
        button.enabled = false
        // isPlayerOne is always true for initial state... once button is tapped the boolean value of isPlayerOne will alternate.
        guard let title = button.currentTitle else { return }
        let indexValue = game.convertStringToTupleFrom(title)
        if isPlayerOne {
            game.setPlayerMarkOn(indexValue, forPlayer: .PlayerOne)
            button.backgroundColor = .redColor()
            isPlayerOne = false
        } else {
            game.setPlayerMarkOn(indexValue, forPlayer: .PlayerTwo)
            button.backgroundColor = .greenColor()
            isPlayerOne = true
        }
        // b4 we check for winner.... we need to set the player value in the ticTacToeState

        if let playerName = game.checkForWinner() {
            gameTitleLabel.text = playerName
            resetAllButtons(shouldResetButtonColor: false, shouldEnableButton: false)
        }
    }

}

