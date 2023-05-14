//
//  SplashScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class SplashScene: BaseScene {
    override func setupUI() {
        setBackground(with: Resources.Backgrounds.splash)
        
        var loadingElements = [SKSpriteNode]()
        
        for i in 0..<7 {
            let loadingElement = SKSpriteNode(imageNamed: Resources.Elements.loading)
            loadingElement.position = CGPoint(x: frame.minX + 80 + 37 * CGFloat(i), y: frame.midY + 120)
            loadingElement.alpha = 0
            loadingElements.append(loadingElement)
            addChild(loadingElement)
        }
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        fadeInAction.timingMode = .easeOut
        let delayAction = SKAction.wait(forDuration: 0.8)

        for i in 0..<loadingElements.count {
            let delayTime = Double(i) * 0.5
            let delay = SKAction.wait(forDuration: delayTime)
            var sequenceAction = SKAction.sequence([delay, fadeInAction, delayAction])
            if i == loadingElements.count - 1 {
                sequenceAction = SKAction.sequence([delay, fadeInAction, delayAction, SKAction.run { self.gameController.presentMenu() }])
            }
            loadingElements[i].run(sequenceAction)
        }
    }
}
