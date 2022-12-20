//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class ComputerInputState: GameState {

    // MARK: - Properties

    private(set) var isCompleted: Bool = false
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?

    let player: Player
    let markViewPrototype: MarkView

    // MARK: - Constructions

    init(player: Player,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView?,
         markViewPrototype: MarkView)
    {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }

    // MARK: - Functions

    func begin() {
        gameViewController?.winnerLabel.isHidden = true
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = false
    }

    func addMark(at position: GameboardPosition) {
        guard
            let gameboardView = gameboardView
        else {
            return
        }

        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markViewPrototype.copy(), at: position)

        isCompleted = true
    }
}
