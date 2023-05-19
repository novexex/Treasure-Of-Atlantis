//
//  ChoosingLevelScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class ChoosingLevelScene: BaseScene {
    
    private var levels = [SKSpriteNode]()
    private var buttons = [SKSpriteNode]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.back:
                        gameController.presentMenu()
                    case Resources.Buttons.right,
                        Resources.Buttons.achivements:
                        gameController.achivementsButtonPressed()
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default:
                        guard let name = node.name else { return }
                        if name.contains(Resources.Buttons.miniStartButton) {
                            chooseLevel(name: name)
                        }
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.choosingLevel)
        setupTopAndBotUI()
        setupBackButton()
        setupAchivementsButton()
         
        let levelCount = 6
        let xStart = (frame.width / 3) - 20
        let yStart = frame.midY + 90

        for i in 1..<levelCount {
            let level = SKSpriteNode(imageNamed: Resources.Elements.level + String(i))
            let xOffset = level.frame.width + 10
            let yOffset = level.frame.height + 50
            var xPos = CGFloat()
            var yPos = CGFloat()
            if i % 2 == 0 {
                xPos = xStart + xOffset
            } else if i % 2 == 1 {
                xPos = xStart
            }
            yPos = yStart + (yOffset * -CGFloat((i-1)/2))
            level.position = CGPoint(x: xPos, y: yPos)
            levels.append(level)
            addChild(level)
        }
        
        let closedLevel = SKSpriteNode(imageNamed: Resources.Elements.closedLevel)
        let element = levels[levels.count-2]
        closedLevel.position = CGPoint(x: element.position.x + 7, y: element.position.y - element.size.height - 55.5)
        addChild(closedLevel)
        
        for i in 1...levels.count {
            var starsColor = String()
            if gameController.gameSetups.isLevelCompleted[i] ?? false {
                starsColor = Resources.Elements.stars
            } else {
                starsColor = Resources.Elements.bwStars
            }
            
            let stars = SKSpriteNode(imageNamed: starsColor)
            stars.position = CGPoint(x: levels[i-1].frame.midX + 3, y: levels[i-1].frame.maxY)
            stars.zPosition = 1
            addChild(stars)
            
            let miniStartButton = SKSpriteNode(imageNamed: Resources.Buttons.miniStartButton)
            miniStartButton.name = Resources.Buttons.miniStartButton + String(i)
            miniStartButton.position = CGPoint(x: levels[i-1].frame.midX, y: levels[i-1].frame.minY)
            miniStartButton.zPosition = 1
            buttons.append(miniStartButton)
            addChild(miniStartButton)
        }
    }
    
    private func chooseLevel(name: String) {
        for i in 1...levels.count {
            if name.contains(String(i)) {
                gameController.startGameButtonPressed(level: i)
            }
        }
    }
}
