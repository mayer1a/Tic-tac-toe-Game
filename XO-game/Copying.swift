//
//  Copying.swift
//  XO-game
//
//  Created by Artem Mayer on 20.12.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Copying {

    // MARK: - Constructions
    
    init(_ prototype: Self)
}

extension Copying {

    // MARK: - Functions

    func copy() -> Self {
        return type(of: self).init(self)
    }
}
