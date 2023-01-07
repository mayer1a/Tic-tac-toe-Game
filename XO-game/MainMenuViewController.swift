//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

protocol GameModeProtocol: AnyObject {
    func setupGameMode(_ isGameWithComputer: Bool)
}

final class MainMenuViewController: UIViewController {

    weak var delegate: GameModeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.subviews.first?.subviews.forEach {
            let button = $0 as? UIButton
            button?.layer.cornerRadius = (button?.layer.frame.height ?? 40) / 3
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }

    @IBAction func playerVersusPlayerButtonTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "GameViewController")

        guard let gameViewController = destinationViewController as? GameViewController else { return }

        gameViewController.modalPresentationStyle = .fullScreen

        present(gameViewController, animated: true)
    }

    @IBAction func playerVersusSystemButtonTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "GameViewController")

        guard let gameViewController = destinationViewController as? GameViewController else { return }

        gameViewController.modalPresentationStyle = .fullScreen
        delegate = gameViewController
        delegate?.setupGameMode(true)
        
        present(gameViewController, animated: true)
    }
    
}
