//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!

    // MARK: - Private properties

    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setFirstState()

        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self
            else { return }

            self.currentState.addMark(at: position)

            if self.currentState.isCompleted {
                self.setNextState()
            }
        }
    }

    // MARK: - Actions

    @IBAction func restartButtonTapped(_ sender: UIButton) { }

    // MARK: - Private functions

    private func setFirstState() {
        currentState = PlayerInputState(player: .first,
                                        gameViewController: self,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView)
    }

    private func setNextState() {
        if let playerInputState = currentState as? PlayerInputState {
            currentState = PlayerInputState(player: playerInputState.player.next,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        }
    }
}

