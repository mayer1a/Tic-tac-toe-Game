//
//  GameExecutionState.swift
//  XO-game
//
//  Created by Artem Mayer on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class GameExecutionState: GameState {

    // MARK: - Properties

    private(set) weak var gameboard: Gameboard?

    var isCompleted: Bool = false

    // MARK: - Construction

    init(gameboard: Gameboard?) {
        self.gameboard = gameboard
    }

    // MARK: - Functions

    func begin() {
        MovesInvoker.shared.executeCommands()
        isCompleted = true
    }

    func addMark(at position: GameboardPosition) { }
}
