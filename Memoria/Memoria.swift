//
//  Memoria.swift
//  Memoria
//
//  Created by Thiago Outeiro Pereira Damasceno on 09/07/19.
//  Copyright © 2019 Thiago Outeiro Pereira Damasceno. All rights reserved.
//

import Foundation

class Memoria{
    var cards = [Card]()
    var turnUpCardIndex: Int?
    
    init(numberOfPairs: Int){
        for _ in 1...numberOfPairs{
            let card = Card.init()
            cards += [card,card]
        }
    }
    
    func haveMatched(indexChosenCard: Int){
        if !cards[indexChosenCard].isMatched{
            guard let turnUpCardIndex = self.turnUpCardIndex else {
                //Nenhuma carta levantada
                for flipIndex in cards.indices{
                    cards[flipIndex].isFacedUp = false
                }
                self.turnUpCardIndex = indexChosenCard
                cards[indexChosenCard].isFacedUp = true
                return
            }
            //Clicou na mesma carta
            if turnUpCardIndex==indexChosenCard { return }
            
            if cards[turnUpCardIndex].id == cards[indexChosenCard].id{
                //Carta que ja estava levanatda igual a carta escolhida
                cards[indexChosenCard].isMatched = true
                cards[turnUpCardIndex].isMatched = true
            }
            
            cards[indexChosenCard].isFacedUp = true
            self.turnUpCardIndex = nil
        }
    }
}
