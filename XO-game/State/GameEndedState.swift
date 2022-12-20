//
//  GameEndedState.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class GameEndedState: GameState {

    // MARK: - Properties

    let winner: Player?
    private(set) var isCompleted: Bool = false
    private(set) weak var gameViewController: GameViewController?

    // MARK: - Constructions

    init(winner: Player, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }

    // MARK: - Functions

    func begin() {
        gameViewController?.winnerLabel.isHidden = false

        if let winner = winner {
            gameViewController?.winnerLabel.text = "\(winnerName(from: winner)) win!"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }

        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true

        log(.gameFinish(winner: winner))
    }

    func addMark(at position: GameboardPosition) { }

    // MARK: - Private functions

    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        }
    }

}
