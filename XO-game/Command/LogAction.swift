//
//  LogAction.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    case gameFinish(winner: Player?)
    case gameRestart
}

public func log(_ action: LogAction) {
    let command = LogCommand(action: action)

    LoggerInvoker.shared.addLogCommand(command)
}
