//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

        present(gameViewController, animated: true)
    }
    
}
