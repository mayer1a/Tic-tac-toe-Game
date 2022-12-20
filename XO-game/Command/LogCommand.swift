//
//  LogCommand.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class LogCommand {

    // MARK: - Properties

    let action: LogAction

    var logMessage: String {
        switch action {
        case .playerInput(let player, let position):
            return "\(player) player placed mark at \(position)"
        case .gameFinish(let winner):
            if let winner = winner {
                return "\(winner) player win game!"
            } else {
                return "Game finished without winner"
            }
        case .gameRestart:
            return "Game was restarted"
        }
    }

    // MARK: - Construction

    init(action: LogAction) {
        self.action = action
    }
}
