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

    var isCompleted: Bool = false

    // MARK: - Functions

    func begin() {
        MovesInvoker.shared.executeCommands()
    }

    func addMark(at position: GameboardPosition) { }
}
