//
//  AchivementsScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class AchivementsScene: BaseScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.back:
                        gameController.backButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.questionMark:
                        gameController.questionMarkButtonPressed()
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.achivements)
        setupTopAndBotUI()
        setupBackButton()
        setupQuestionMarkButton()
        
        // Setup achivements
        let heartAchivement = SKSpriteNode(texture: getTexture(named: Resources.Achivmenets.Images.heart))
        guard let size = heartAchivement.texture?.size() else { return }
        heartAchivement.position = CGPoint(x: frame.midX - size.width / 2, y: scoreAmount.position.y - 200)
        addChild(heartAchivement)
        
        let shieldAchivement = SKSpriteNode(texture: getTexture(named: Resources.Achivmenets.Images.shield))
        shieldAchivement.position = CGPoint(x: heartAchivement.position.x + size.width, y: heartAchivement.position.y)
        addChild(shieldAchivement)
        
        let ringAchivement = SKSpriteNode(texture: getTexture(named: Resources.Achivmenets.Images.ring))
        ringAchivement.position = CGPoint(x: heartAchivement.position.x, y: heartAchivement.position.y - size.height)
        addChild(ringAchivement)
        
        let cupAchivement = SKSpriteNode(texture: getTexture(named: Resources.Achivmenets.Images.cup))
        cupAchivement.position = CGPoint(x: shieldAchivement.position.x, y: ringAchivement.position.y)
        addChild(cupAchivement)
        
        let moneyBagAchivement = SKSpriteNode(texture: getTexture(named: Resources.Achivmenets.Images.moneyBag))
        moneyBagAchivement.position = CGPoint(x: frame.midX, y: cupAchivement.position.y - size.height)
        addChild(moneyBagAchivement)
    }
    
    private func getTexture(named: String) -> SKTexture {
        let image = UIImage(named: named)
        var name = named.replacingOccurrences(of: "Achivement", with: "", range: named.startIndex..<named.endIndex)
        let firstChar = name.prefix(1).lowercased()
        name = firstChar + name.dropFirst()
        if gameController.gameSetups.achivements[name] ?? false {
            return SKTexture(image: image ?? UIImage())
        } else {
            let blackAndWhiteImage = image?.noir()
            return SKTexture(image: blackAndWhiteImage ?? UIImage())
        }
    }
}
