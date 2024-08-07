//
//  MapScene.swift
//  monster-hunter-game
//
//  Created by Dima Tavlui on 07.08.2024.
//

import SpriteKit

class MapScene: SKScene {
    let background = Background()
    
    override func didMove(to view: SKView) {
        background.createBackground(to: self, image: "background1")
        
        createLevelButton()
        
        createLabel()
    }
    
    func createLabel() {
        let labelSize = CGSize(width: 400, height: 75)
        
        let shapeNode = SKShapeNode(rectOf: labelSize, cornerRadius: 15)
        shapeNode.fillColor = .systemPurple
        shapeNode.strokeColor = .black
        shapeNode.lineWidth = 1.5
        
        let lable = SKLabelNode(text: "Choose the level")
        lable.position = CGPoint(x: frame.midX, y: frame.midY + 300)
        lable.fontColor = .black
        lable.color = .white
        lable.fontName = "Helvetica"
        lable.fontSize = 45
        
        shapeNode.position = CGPoint(x: 0, y: 15)
        lable.addChild(shapeNode)
        
        self.addChild(lable)
    }
    
    func createLevelButton() {
        let buttonSize = CGSize(width: 150, height: 75)
        
        let shapeNode = SKShapeNode(rectOf: buttonSize, cornerRadius: 15)
        shapeNode.fillColor = .systemPurple
        shapeNode.strokeColor = .black
        shapeNode.lineWidth = 2
        
        let playButton = SKSpriteNode(color: .clear, size: buttonSize)
        playButton.name = "levelButton"
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)

        shapeNode.position = CGPoint(x: 0, y: 0)
        playButton.addChild(shapeNode)
        
        let playButtonLabel = SKLabelNode(text: "Level 1")
        playButtonLabel.fontSize = 35
        playButtonLabel.fontName = "Helvetica"
        playButtonLabel.fontColor = SKColor.white
        playButtonLabel.verticalAlignmentMode = .center
        playButtonLabel.position = CGPoint(x: 0, y: 0)
        playButton.addChild(playButtonLabel)
        
        self.addChild(playButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if touchedNode.name == "levelButton" || touchedNode.parent?.name == "levelButton" {
                touchedNode.run(SKAction.scale(to: 0.9, duration: 0.1))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if touchedNode.name == "levelButton" || touchedNode.parent?.name == "levelButton" {
                touchedNode.run(SKAction.scale(to: 1.0, duration: 0.1))
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = self.scaleMode
                let transition = SKTransition.moveIn(with: .up, duration: 0.5)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if touchedNode.name == "levelButton" || touchedNode.parent?.name == "levelButton" {
                touchedNode.run(SKAction.scale(to: 1.0, duration: 0.1))
            }
        }
    }
}
