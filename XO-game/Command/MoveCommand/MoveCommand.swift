//
//  MoveCommand.swift
//  XO-game
//
//  Created by Artem Mayer on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class MoveCommand {

    // MARK: - Properties

    private let player: Player
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?
    private let position: GameboardPosition

    // MARK: - Construction

    init(player: Player, gameboard: Gameboard?, position: GameboardPosition, gameboardView: GameboardView?) {
        self.player = player
        self.gameboard = gameboard
        self.position = position
        self.gameboardView = gameboardView
    }

    // MARK: - Functions

    func execute() {
        guard let gameboardView = gameboardView else { return }

        if !gameboardView.canPlaceMarkView(at: position) {
            gameboardView.removeMarkView(at: position)
        }

        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(player.markViewPrototype, at: position)
    }
}
