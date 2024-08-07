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
        background.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        background.size = CGSize(width: scene.size.width, height: scene.size.height)
        background.zPosition = -1
        scene.addChild(background)
    }
    
    func createBackgoundGame(to scene: SKScene) {
        let bgTexture = SKTexture(imageNamed: "background3")
        let moveBg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 10)
        let replaceBg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, replaceBg]))
        
        for i in 0...2 {
            let background = SKSpriteNode(texture: bgTexture)
            background.position = CGPoint(x: bgTexture.size().width / 2 + bgTexture.size().width * CGFloat(i), y: scene.size.height / 2)
            background.size.height = scene.size.height
            background.run(moveBgForever)
            background.zPosition = -1
            
            scene.addChild(background)
        }
    }
}
