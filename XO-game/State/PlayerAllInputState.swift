//
//  PlayerAllInputState.swift
//  XO-game
//
//  Created by Artem Mayer on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class PlayerAllInoutState: GameState {

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
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }

        gameViewController?.winnerLabel.isHidden = true
    }

    func addMark(at position: GameboardPosition) {
        let command = MoveCommand(player: player, gameboard: gameboard, position: position, gameboardView: gameboardView)
        MovesInvoker.shared.addMoveCommand(command)

        isCompleted = true
//        MovesInvoker.shared.onCollectingPlayerMovesNumber = { [weak self] isCompleted in
//            self?.isCompleted = isCompleted
//        }

        log(.playerInput(player: player, position: position))
    }
}
