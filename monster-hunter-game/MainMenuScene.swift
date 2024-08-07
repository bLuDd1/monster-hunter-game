import SpriteKit

class MainMenuScene: SKScene {
    
    let properties = Properties()
    
    override func didMove(to view: SKView) {
        properties.createBackground(to: self, image: "background")
        
        createPlayButton()
        
        createMainLabel()
    }
    
    func createMainLabel() {
        let lable = SKLabelNode(text: "Monster Hunter")
        lable.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        lable.fontColor = .black
        lable.fontName = "Helvetica"
        lable.fontSize = 45
        
        self.addChild(lable)
    }
    
    func createPlayButton() {
        let buttonSize = CGSize(width: 150, height: 75)
        
        let shapeNode = SKShapeNode(rectOf: buttonSize, cornerRadius: 15)
        shapeNode.fillColor = .systemPurple
        shapeNode.strokeColor = .black
        shapeNode.lineWidth = 2
        
        let playButton = SKSpriteNode(color: .clear, size: buttonSize)
        playButton.name = "playButton"
        playButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)

        shapeNode.position = CGPoint(x: 0, y: 0)
        playButton.addChild(shapeNode)
        
        let playButtonLabel = SKLabelNode(text: "Play")
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
            
            if touchedNode.name == "playButton" || touchedNode.parent?.name == "playButton" {
                touchedNode.run(SKAction.scale(to: 0.9, duration: 0.1))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if touchedNode.name == "playButton" || touchedNode.parent?.name == "playButton" {
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
            
            if touchedNode.name == "playButton" || touchedNode.parent?.name == "playButton" {
                touchedNode.run(SKAction.scale(to: 1.0, duration: 0.1))
            }
        }
    }
}
