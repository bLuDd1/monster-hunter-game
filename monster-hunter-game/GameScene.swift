//
//  GameScene.swift
//  monster-hunter-game
//
//  Created by Dima Tavlui on 06.08.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let background = Background()
    
    // Textures
    var playerTexture: SKTexture!
    var monsterTextures: [SKTexture]!
    var slimeTexture: SKTexture!
    
    // Properties
    var player = SKSpriteNode()
    var scoreLabel: SKLabelNode!
    var livesLabel: SKLabelNode!
    var score = 0
    var lives = 3
    
    var isTouching = false
    
    let playerCategory: UInt32 = 0x1 << 0
    let monsterCategory: UInt32 = 0x1 << 1
    let slimeCategory: UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView) {
        playerTexture = SKTexture(imageNamed: "player")
        background.createBackgoundGame(to: self)
        
        self.physicsWorld.contactDelegate = self
        
        player = SKSpriteNode(texture: playerTexture)
        player.size = CGSize(width: 100, height: 100)
        player.position = CGPoint(x: self.frame.midX - 150, y: self.frame.midY)
        player.physicsBody = SKPhysicsBody(texture: playerTexture, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = monsterCategory | slimeCategory
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.isDynamic = true
        self.addChild(player)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: 100, y: self.frame.height - 40)
        self.addChild(scoreLabel)
        
        livesLabel = SKLabelNode(text: "Lives: 3")
        livesLabel.fontSize = 24
        livesLabel.fontColor = SKColor.black
        livesLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 40)
        self.addChild(livesLabel)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1)
            ])
        ))
                
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addSlime),
                SKAction.wait(forDuration: 5.0)
            ])
        ))
    }
    
    func addMonster() {
        monsterTextures = [SKTexture(imageNamed: "monst1"), SKTexture(imageNamed: "monst2"), SKTexture(imageNamed: "monst3")]
        let randomTexture = monsterTextures.randomElement()!
        let monster = SKSpriteNode(texture: randomTexture)
        monster.size = CGSize(width: 100, height: 75)
        let randomY = CGFloat.random(in: 40...self.frame.height - 40)
        monster.position = CGPoint(x: self.frame.width + monster.size.width, y: randomY)
        monster.physicsBody = SKPhysicsBody(texture: randomTexture, size: monster.size)
        monster.physicsBody?.affectedByGravity = false
        monster.physicsBody?.categoryBitMask = monsterCategory
        monster.physicsBody?.contactTestBitMask = playerCategory
        monster.physicsBody?.collisionBitMask = 0
        monster.physicsBody?.isDynamic = true
        self.addChild(monster)
            
        let moveAction = SKAction.moveTo(x: -monster.size.width, duration: 4.0)
        let removeAction = SKAction.removeFromParent()
        monster.run(SKAction.sequence([moveAction, removeAction]))
    }
        
    func addSlime() {
        slimeTexture = SKTexture(imageNamed: "slime")
        let slime = SKSpriteNode(texture: slimeTexture)
        slime.size = CGSize(width: 50, height: 50)
        let randomY = CGFloat.random(in: 40...self.frame.height - 40)
        slime.position = CGPoint(x: self.frame.width + slime.size.width, y: randomY)
        slime.physicsBody = SKPhysicsBody(rectangleOf: slime.size)
        slime.physicsBody?.affectedByGravity = false
        slime.physicsBody?.categoryBitMask = slimeCategory
        slime.physicsBody?.contactTestBitMask = playerCategory
        slime.physicsBody?.collisionBitMask = 0
        slime.physicsBody?.isDynamic = true
        self.addChild(slime)
        
        let moveAction = SKAction.moveTo(x: -slime.size.width, duration: 4.0)
        let removeAction = SKAction.removeFromParent()
        slime.run(SKAction.sequence([moveAction, removeAction]))
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
            isTouching = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.position.y > self.frame.height {
            player.position.y = self.frame.height
            print(self.frame.height)
        } else if player.position.y < 10 {
            player.position.y = 10
        }
        
        if isTouching {
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 200)
        }
    }
        
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == (playerCategory | monsterCategory) {
            if let monster = contact.bodyA.categoryBitMask == monsterCategory ? contact.bodyA.node : contact.bodyB.node {
                monster.removeFromParent()
                score += 1
                scoreLabel.text = "Score: \(score)"
            }
        } else if contactMask == (playerCategory | slimeCategory) {
            if let slime = contact.bodyA.categoryBitMask == slimeCategory ? contact.bodyA.node : contact.bodyB.node {
                slime.removeFromParent()
                lives -= 1
                livesLabel.text = "Lives: \(lives)"
                    
                if lives == 0 {
                    let mainMenuScene = MainMenuScene(size: self.size)
                    mainMenuScene.scaleMode = self.scaleMode
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    self.view?.presentScene(mainMenuScene, transition: transition)
                }
            }
        }
    }
}
