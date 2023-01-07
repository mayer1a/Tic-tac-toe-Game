//
//  GameState.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {

    // MARK: - Properties
    
    var isCompleted: Bool { get }

    // MARK: - Functions

    func begin()
    func addMark(at position: GameboardPosition)
}
