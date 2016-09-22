//
//  TicTacToe.swift
//  TicTacGame
//
//  Created by Jason Wang on 9/20/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class TicTacToe {

    enum State {
        case Empty
        case PlayerOne
        case PlayerTwo
    }

    var ticTacToeState = [[State]]()
    let gameSize: Int

    init(gameSize: Int) {
        self.gameSize = gameSize
    }

    func resetGameState() {
        ticTacToeState.removeAll()
        for _ in 0..<gameSize {
            let row = Array(count: gameSize, repeatedValue: State.Empty)
            ticTacToeState.append(row)
        }
    }

    func checkForWinner() -> String? {
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
        return winnerName
    }

    private func checkAllRowWinner() -> State? {
        for row in 0..<gameSize {
            var rowStates = [State]()
            for col in 0..<gameSize {
                rowStates.append(ticTacToeState[row][col])
            }
            guard let playerWinner = checkArrWinner(rowStates) else { continue }

            return playerWinner
        }
        return nil
    }

    private func checkArrWinner(arr: [State]) -> State? {
        let winnerArray = Array(Set(arr))
        if winnerArray.count == 1 {
            if winnerArray.first != .Empty {
                return winnerArray.first
            }
        }
        return nil
    }


    private func checkAllColWinner() -> State? {
        for col in 0..<gameSize {
            var colStates = [State]()
            for row in 0..<gameSize {
                colStates.append(ticTacToeState[row][col])
            }
            guard let colWinner = checkArrWinner(colStates) else { continue }
            return colWinner
        }
        return nil
    }

    private func checkAllDiagonalWinner() -> State? {
        var fowardDiagonalWinner = [State]()
        var backWardDiagonalWinner = [State]()
        for row in 0..<gameSize {
            for col in 0..<gameSize {
                if row == col {
                    fowardDiagonalWinner.append(ticTacToeState[row][col])
                }
                if row + col == (gameSize - 1) {
                    backWardDiagonalWinner.append(ticTacToeState[row][col])
                }
            }
        }

        if let fdwName = checkArrWinner(fowardDiagonalWinner) {
            return fdwName
        }

        if let bdwName = checkArrWinner(backWardDiagonalWinner) {
            return bdwName
        }
        return nil
    }

    func setPlayerMarkOn(position: (Int, Int), forPlayer: State) {
        ticTacToeState[position.0][position.1] = forPlayer
    }

    func convertStringToTupleFrom(title: String) -> (Int, Int) {
        let numbers = title.componentsSeparatedByString(",")
        let tuple = (Int(numbers[0])!, Int(numbers[1])!)
        return tuple
    }
    
}
