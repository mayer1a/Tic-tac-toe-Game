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

    // MARK: - Properties

    var isGameWithComputer: Bool = false

    // MARK: - Private properties

    private let gameboard = Gameboard()
    private lazy var computerAlgorithm = ComputerAlgorithm(gameboardView: gameboardView)
    private lazy var referee = Referee(gameboard: gameboard)
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

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboard.clear()
        gameboardView.clear()
        computerAlgorithm.clear()
        setFirstState()
        
        log(.gameRestart)
    }

    // MARK: - Private functions

    private func setFirstState() {
        if isGameWithComputer {
            currentState = PlayerInputState(player: .first,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView,
                                            markViewPrototype: Player.first.markViewPrototype)
        } else {
            currentState = PlayerAllInputState(player: .first,
                                               gameViewController: self,
                                               gameboard: gameboard,
                                               gameboardView: gameboardView,
                                               markViewPrototype: Player.first.markViewPrototype)
        }
    }

    private func setNextState() {
        if let winner = referee.determineWinner() {
            gameShouldEnded(with: winner)
            return
        } else if gameboardView.markViewForPosition.count >= 9 {
            gameShouldEnded()
            return
        }

        if isGameWithComputer {
            setNextStateWithComputer()
        } else {
            setNextStateWithPlayer()
        }
    }

    private func setNextStateWithPlayer() {
        guard
            let playerInputState = currentState as? PlayerAllInputState
        else {
            currentState = GameEndedState(winner: referee.determineWinner(), gameViewController: self)
            return
        }

        if playerInputState.player == .second {
            currentState = GameExecutionState(gameboard: gameboard)
            currentState = GameEndedState(winner: referee.determineWinner(), gameViewController: self)
        } else {
            currentState = PlayerAllInputState(player: playerInputState.player.next,
                                               gameViewController: self,
                                               gameboard: gameboard,
                                               gameboardView: gameboardView,
                                               markViewPrototype: playerInputState.player.next.markViewPrototype)
        }
    }

    private func setNextStateWithComputer() {
        currentState = ComputerInputState(player: .second,
                                          gameViewController: self,
                                          gameboard: gameboard,
                                          gameboardView: gameboardView,
                                          markViewPrototype: Player.second.markViewPrototype)

        guard
            let nextPosition = computerAlgorithm.getNextMarkPosition()
        else {
            gameShouldEnded(with: referee.determineWinner())
            return
        }

        currentState.addMark(at: nextPosition)

        if let winner = referee.determineWinner() {
            gameShouldEnded(with: winner)
            return
        }

        currentState = PlayerInputState(player: .first,
                                        gameViewController: self,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView,
                                        markViewPrototype: Player.first.markViewPrototype)
    }

    private func gameShouldEnded(with winner: Player? = nil) {
        currentState = GameEndedState(winner: winner, gameViewController: self)
    }
}

extension GameViewController: GameModeProtocol {

    func setupGameMode(_ isGameWithComputer: Bool) {
        self.isGameWithComputer = isGameWithComputer
    }
}
