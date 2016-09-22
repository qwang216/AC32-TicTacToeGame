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

    func resetGameState() {
        ticTacToeState.removeAll()
        for _ in 0..<3 {
            let row = Array(count: 3, repeatedValue: State.Empty)
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
        for row in 0..<3 {
            var rowStates = [State]()
            for col in 0..<3 {
                rowStates.append(ticTacToeState[row][col])
//                if ticTacToeState[row][col] == .PlayerOne {
//                    rowStates.append(.PlayerOne)
//                } else if ticTacToeState[row][col] == .PlayerTwo {
//                    rowStates.append(.PlayerTwo)
//                } else {
//                    rowStates.append(.Empty)
//                }
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
//            if winnerArray.first == .PlayerOne {
//                return .PlayerOne
//            } else if winnerArray.first == .PlayerTwo {
//                return .PlayerTwo
//            } else {
//                return nil
//            }
        }
        return nil
    }


    private func checkAllColWinner() -> State? {
        for col in 0..<3 {
            var colStates = [State]()
            for row in 0..<3 {
                colStates.append(ticTacToeState[row][col])
//                if ticTacToeState[row][col] == .PlayerOne {
//                    colStates.append(.PlayerOne)
//                } else if ticTacToeState[row][col] == . PlayerTwo {
//                    colStates.append(.PlayerTwo)
//                } else {
//                    colStates.append(.Empty)
//                }
            }
            guard let colWinner = checkArrWinner(colStates) else { continue }
            return colWinner
        }
        return nil
    }

    private func checkAllDiagonalWinner() -> State? {
        var fowardDiagonalWinner = [State]()
        var backWardDiagonalWinner = [State]()
        for row in 0..<3 {
            for col in 0..<3 {
                if row == col {
                    fowardDiagonalWinner.append(ticTacToeState[row][col])
                }
                if row + col == 2 {
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

//        let fdw = Array(Set(fowardDiagonalWinner))
//        if fdw.count == 1 && fdw.first != .Empty {
//            return fdw.first
//        }

//        var backWardDiagonalWinner = [State]()
//        for row in 0..<3 {
//            for col in 0..<3 {
//                if row + col == 2 {
//                    backWardDiagonalWinner.append(ticTacToeState[row][col])
//                }
//            }
//        }

//
//        let bdw = Array(Set(backWardDiagonalWinner))
//        if bdw.count == 1 && bdw.first != .Empty {
//            return bdw.first
//        }
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
