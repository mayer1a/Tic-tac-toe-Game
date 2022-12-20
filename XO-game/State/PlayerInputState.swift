//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class PlayerInputState: GameState {

    // MARK: - Properties

    private(set) var isCompleted: Bool = false
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?

    let player: Player

    // MARK: - Constructions

    init(player: Player,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView?)
    {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
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
        guard
            let gameboardView = gameboardView,
            gameboardView.canPlaceMarkView(at: position)
        else {
            return
        }

        let markView: MarkView

        switch player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }

        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markView, at: position)

        isCompleted = true
    }
}
