//
//  SplashScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class SplashScene: BaseScene {
    
    private var loadingElements = [SKSpriteNode]()
    
    override func setupUI() {
        setBackground(with: Resources.Backgrounds.splash)
        
        setupElements()
        animation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.gameController.presentMenu()
        }
    }
    
    private func setupElements() {
        for i in 0..<7 {
            let loadingElement = SKSpriteNode(imageNamed: Resources.Elements.loading)
            loadingElement.position = CGPoint(x: frame.minX + 80 + 37 * CGFloat(i), y: frame.midY + 120)
            loadingElement.alpha = 0
            loadingElements.append(loadingElement)
            addChild(loadingElement)
        }
    }
    
    private func animation() {
        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        fadeInAction.timingMode = .easeOut
        let delayAction = SKAction.wait(forDuration: 0.2)

        for i in 0..<loadingElements.count {
            let delayTime = Double(i) * 0.2
            let delay = SKAction.wait(forDuration: delayTime)
            var sequenceAction = SKAction.sequence([delay, fadeInAction, delayAction])
            if i == loadingElements.count - 1 {
                sequenceAction = SKAction.sequence([delay, fadeInAction, SKAction.run { self.removeElements() }, SKAction.run { self.animation() }])
            }
            loadingElements[i].run(sequenceAction)
        }
    }
    
    private func removeElements() {
        for i in loadingElements {
            let run = SKAction.fadeOut(withDuration: 0.2)
            i.run(run)
        }
    }
}
