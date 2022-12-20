//
//  ComputerAlgorithm.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class ComputerAlgorithm {

    // MARK: - Private properties

    private let gameboardView: GameboardView?
    private var stepNumber: Int
    private var completedMoves: [[Int]]

    // MARK: - Construction

    init(gameboardView: GameboardView?) {
        self.gameboardView = gameboardView
        self.stepNumber = 0
        self.completedMoves = []
    }

    // MARK: - Functions

    func getNextMarkPosition() -> GameboardPosition? {
        return calculateNextPositon()
    }

    func clear() {
        stepNumber = 0
        completedMoves = []
    }

    // MARK: - Private functions

    private func calculateNextPositon() -> GameboardPosition? {
        if gameboardView?.markViewForPosition.count ?? 0 >= 9 {
            return nil
        }

        let possibleMoves = getPossibleMoves()

        stepNumber += 1

        for possibleMove in possibleMoves {
            let possibleNextPosition = GameboardPosition(column: possibleMove[0], row: possibleMove[1])

            if gameboardView?.canPlaceMarkView(at: possibleNextPosition) == true {
                completedMoves.append(possibleMove)
                return possibleNextPosition
            }
        }

        var nextPosition = getRandomNextPosition()

        while gameboardView?.canPlaceMarkView(at: nextPosition) == false {
            nextPosition = getRandomNextPosition()
        }

        completedMoves.append([nextPosition.column, nextPosition.row])

        return nextPosition
    }

    private func getPossibleMoves() -> [[Int]] {
        var possibleMoves: [[Int]] = []

        switch stepNumber {
        case 0:
            possibleMoves = [[1, 1], [0, 0], [2, 0], [0, 2], [2, 2]]
        case 1:
            if completedMoves[0] == [1, 1] {
                possibleMoves = [[0, 0], [2, 0], [0, 2], [2, 2]]
            }
        case 2:
            if completedMoves[0] == [1, 1] {
                switch completedMoves[1] {
                case [0, 0]: possibleMoves = [[2, 2]]
                case [2, 0]: possibleMoves = [[0, 2]]
                case [0, 2]: possibleMoves = [[2, 0]]
                case [2, 2]: possibleMoves = [[0, 0]]
                default: break
                }
            }
        default:
            break
        }

        return possibleMoves
    }

    private func getRandomNextPosition() -> GameboardPosition {
        GameboardPosition(column: Int.random(in: 0..<3), row: Int.random(in: 0..<3))
    }
}
