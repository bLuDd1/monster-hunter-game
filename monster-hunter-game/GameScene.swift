//
//  GameScene.swift
//  monster-hunter-game
//
//  Created by Dima Tavlui on 06.08.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let background = Background()
    
    override func didMove(to view: SKView) {
        background.createBackgoundGame(to: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
