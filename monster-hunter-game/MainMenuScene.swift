//
//  MainMenuScene.swift
//  monster-hunter-game
//
//  Created by Dima Tavlui on 06.08.2024.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    let background = Background()
    
    override func didMove(to view: SKView) {
        background.createBackground(to: self, image: "background")
    }
}
