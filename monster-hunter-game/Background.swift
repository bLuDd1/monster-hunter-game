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
//        background.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
//        
//        background.size = CGSize(width: scene.size.width, height: scene.size.width / background.size.width * background.size.height)
//        if background.size.height < scene.size.height {
//            background.size = CGSize(width: scene.size.height / background.size.height * background.size.width, height: scene.size.height)
//        }
        background.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        background.size = CGSize(width: scene.size.width, height: scene.size.height)
        print(scene.size.width, scene.size.height)
        
        background.zPosition = -1
        scene.addChild(background)
    }
}
