//
//  Card.swift
//  Memoria
//
//  Created by Thiago Outeiro Pereira Damasceno on 09/07/19.
//  Copyright © 2019 Thiago Outeiro Pereira Damasceno. All rights reserved.
//

import UIKit

struct Card{
    var isFacedUp = false
    var isMatched = false
    var id: Int
    
    static var identifierCount = 0
    static func getUniqueIdentifier() -> Int{
        identifierCount += 1
        return identifierCount
    }
    init(){
        self.id = Card.getUniqueIdentifier()
    }
    
}
