//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class LoggerInvoker {

    // MARK: - Properties

    static let shared = LoggerInvoker()

    // MARK: - Private properties

    private let logger = Logger()
    private let batchSize = 10
    private var commands: [LogCommand] = []

    // MARK: - Functions

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)

        executeCommandsIfNeeded()
    }

    // MARK: - Private functions

    private func executeCommandsIfNeeded() {
        guard commands.count >= batchSize else { return }

        commands.forEach {
            self.logger.writeLogMessage($0.logMessage)
        }

        commands = []
    }
}
