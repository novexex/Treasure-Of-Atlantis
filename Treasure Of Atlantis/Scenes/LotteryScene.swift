//
//  LotteryScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class LotteryScene: BaseScene {
    override func setupUI() {
        setBackground(with: Resources.Backgrounds.lottery)
        setupTopAndBotUI()
        setupBackAndQuestionMarkButtons()
    }
}
