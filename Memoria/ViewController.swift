//
//  ViewController.swift
//  Memoria
//
//  Created by Thiago Outeiro Pereira Damasceno on 09/07/19.
//  Copyright © 2019 Thiago Outeiro Pereira Damasceno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0{
        didSet{
            flipLabel.text = "Vezes viradas\n\(flipCount)"
        }
    }
    
    var highScore = 0{
        didSet{
            highScoreLabel.text = "HighScore\n\(highScore)"
        }
    }
    
    lazy var jogoDaMemoria: Memoria = Memoria.init(numberOfPairs: cardButtons.count/2)

    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.firstIndex(of: sender){
            jogoDaMemoria.haveMatched(indexChosenCard: cardIndex)
            
            self.updateView()
        }
    }
    
    func updateView(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = jogoDaMemoria.cards[index]
            if card.isFacedUp{
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitle(takeEmoji(for: card), for: UIControl.State.normal)
            }
            else if card.isMatched{
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                button.setTitle("", for: UIControl.State.normal)
            }
            else{
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
            
        }
    }
    
    var possibleEmojis = [String]()
    
    var emojis = [Int:String]()
    
    func takeEmoji(for card: Card) -> String{
        if emojis[card.id] == nil, possibleEmojis.count>0{
            let randomIndex = Int(arc4random_uniform(UInt32(possibleEmojis.count)))
            emojis[card.id] = possibleEmojis.remove(at:randomIndex)
        }
        return emojis[card.id] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restart()
    }
    
    @IBAction func newGameTapped(_ sender: Any) {
        restart()
    }
    
    func restart(){
        
        self.seeHighScore()
        possibleEmojis = ["🎃","👻","🤖","👽","😈","👹","💩","👾","🤠","🤢","🤑","🥶","🥵","🤩","😻"]
        jogoDaMemoria = Memoria.init(numberOfPairs: cardButtons.count/2)
        jogoDaMemoria.cards.shuffle()
        
        flipCount = 0
        self.updateView()
    }
    
    func seeHighScore(){
        if (highScore == 0 || highScore > flipCount), jogoDaMemoria.isGameComplete(){
            highScore = flipCount
        }
    }


}

