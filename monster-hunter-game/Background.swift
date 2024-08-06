//
//  Background.swift
//  monster-hunter-game
//
//  Created by Dima Tavlui on 06.08.2024.
//

import SpriteKit

class Background {
    func createBackground(to scene: SKScene, image: String) {
        let background = SKSpriteNode(imageNamed: image)
        background.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        background.size = scene.frame.size
        background.zPosition = -1
        scene.addChild(background)
    }
}
