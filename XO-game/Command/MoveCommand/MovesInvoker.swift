//
//  MovesInvoker.swift
//  XO-game
//
//  Created by Artem Mayer on 21.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class MovesInvoker {

    // MARK: - Properties

    static let shared = MovesInvoker()
    var onCollectingPlayerMovesNumber: ((Bool) -> Void)?

    // MARK: - Private properties
    
    private var commands: [MoveCommand] = []

    // MARK: - Functions

    func addMoveCommand(_ command: MoveCommand) {
        commands.append(command)

        checkPlayerMovesNumber()
    }

    func executeCommands() {
        for commandNumber in 0..<commands.count / 2 {
            commands[commandNumber].execute()
            commands[commandNumber + 5].execute()
        }

        commands = []
    }

    // MARK: - Private functions

    private func checkPlayerMovesNumber() {
        if commands.count == 5 {
            onCollectingPlayerMovesNumber?(true)
        }
    }
}
