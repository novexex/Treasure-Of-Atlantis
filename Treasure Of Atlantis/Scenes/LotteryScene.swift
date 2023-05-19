//
//  LotteryScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class LotteryScene: BaseScene {
    var isBonusClaimed = false {
        didSet {
            if isBonusClaimed {
                gameController.lastLotteryPlay = Date()
                gameController.saveGameSetup()
            }
        }
    }
    private var seashellButtons = Array(repeating: Array(repeating: SKSpriteNode(), count: 2), count: 3)
    private var winningAmount = [1000, 500, 500, 500, 0, 0]
    
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
                    default:
                        guard let name = node.name else { return }
                        if !isBonusClaimed && name.contains(Resources.Elements.closedSeashell) {
                            touchHandling(name: name)
                        }
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.lottery)
        setupTopAndBotUI()
        setupBackButton()
        setupQuestionMarkButton()
        winningAmount.shuffle()
        
        guard let size = SKSpriteNode(imageNamed: Resources.Elements.closedSeashell).texture?.size() else { return }
        let basePosition = CGPoint(x: frame.midX - (size.width / 2) - 10, y: scoreAmount.frame.minY - 190)
        let horizontalSpacing: CGFloat = 20
        let verticalSpacing: CGFloat = 40
        
        for row in 0..<seashellButtons.count {
            for col in 0..<seashellButtons[row].count {
                let index = row * seashellButtons[row].count + col + 1
                let seashellButton = SKSpriteNode(imageNamed: Resources.Elements.closedSeashell)
                seashellButton.name = Resources.Elements.closedSeashell + String(index)
                
                let offsetX = (size.width + horizontalSpacing) * CGFloat(col)
                let offsetY = (size.height + verticalSpacing) * CGFloat(row)
                seashellButton.position = CGPoint(x: basePosition.x + offsetX, y: basePosition.y - offsetY)
                
                seashellButtons[row][col] = seashellButton

                addChild(seashellButton)
            }
        }
    }
    
    private func touchHandling(name: String) {
        for i in 0...(seashellButtons.count * seashellButtons[0].count) {
            if name.contains(String(i)) {
                let row = (i-1) / 2
                let col = (i-1) % 2
                seashellButtons[row][col].texture = SKTexture(imageNamed: Resources.Elements.openSeashell)
                if let size = seashellButtons[row][col].texture?.size() {
                    seashellButtons[row][col].size = CGSize(width: size.width, height: size.height)
                }
                let randomIndex = Int.random(in: 0..<winningAmount.count)
                let randomAmount = winningAmount.remove(at: randomIndex)
                if randomAmount == 0 {
                    isBonusClaimed = true
                    
                    
                    
                    let attributedText = NSMutableAttributedString()
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .center
                    paragraphStyle.lineSpacing = -4
                    
                    let secondLineParagraphStyle = NSMutableParagraphStyle()
                    secondLineParagraphStyle.alignment = .center
                    secondLineParagraphStyle.lineSpacing = 0
                    
                    let font = UIFont(name: Resources.Fonts.EvilEmpire_Regular, size: 28) ?? UIFont.systemFont(ofSize: 28)
                    let thirdLineFont = font.withSize(34)
                    let textColor = UIColor(named: Resources.Colors.blue) ?? .blue
                    
                    let lineAttributes: [NSAttributedString.Key: Any] = [
                        .paragraphStyle: paragraphStyle,
                        .font: font,
                        .foregroundColor: textColor
                    ]
                    let secondLineAttributes: [NSAttributedString.Key: Any] = [
                        .paragraphStyle: secondLineParagraphStyle,
                        .font: font,
                        .foregroundColor: textColor
                    ]
                    let thirdLineAttributes: [NSAttributedString.Key: Any] = [
                        .paragraphStyle: paragraphStyle,
                        .font: thirdLineFont,
                        .foregroundColor: textColor
                    ]
                    
                    let firstLine = NSAttributedString(string: "OH. YOU\n", attributes: lineAttributes)
                    let secondLine = NSAttributedString(string: "LOSE\n", attributes: secondLineAttributes)
                    let thirdLine = NSAttributedString(string: String(randomAmount), attributes: thirdLineAttributes)

                    attributedText.append(firstLine)
                    attributedText.append(secondLine)
                    attributedText.append(thirdLine)
                    
                    let amountLabel = SKLabelNode(attributedText: attributedText)
                    amountLabel.numberOfLines = 3
                    amountLabel.horizontalAlignmentMode = .center
                    amountLabel.verticalAlignmentMode = .center
                    amountLabel.zPosition = 1
                    amountLabel.position = CGPoint(x: seashellButtons[row][col].frame.midX + 1.5, y: seashellButtons[row][col].frame.midY + 7)
                    addChild(amountLabel)
                } else {
                    gameController.scoreAmount += randomAmount
                    
                    let winElement = SKSpriteNode(imageNamed: Resources.Elements.win)
                    winElement.zPosition = 1
                    winElement.position = CGPoint(x: seashellButtons[row][col].frame.midX, y: seashellButtons[row][col].frame.maxY - 50)
                    addChild(winElement)
                    
                    let amountLabel = SKLabelNode(text: String(randomAmount))
                    amountLabel.fontName = Resources.Fonts.EvilEmpire_Regular
                    amountLabel.fontSize = 34
                    amountLabel.fontColor = UIColor(named: Resources.Colors.blue)
                    amountLabel.zPosition = 1
                    amountLabel.position = CGPoint(x: seashellButtons[row][col].frame.midX, y: seashellButtons[row][col].frame.midY - 30)
                    addChild(amountLabel)
                }
            }
        }
    }
}
