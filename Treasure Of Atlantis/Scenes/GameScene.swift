
import SpriteKit

class GameScene: BaseScene {
    let level: Int
    
    private var levelScore = 0 {
        didSet {
            gameController.scoreAmount += levelScore - oldValue
        }
    }
    private var tilesBackground = [[SKSpriteNode]]() {
        didSet {
            tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: colCount), count: rowCount)
        }
    }
    private var tiles = [[SKSpriteNode]]()
    private let spacing: CGFloat = 3
    
    private var rowCount: Int {
        tilesBackground.count
    }
    private var colCount: Int {
        tilesBackground[0].count
    }
    
    init(level: Int, size: CGSize, gameController: GameViewController) {
        self.level = level
        super.init(size: size, gameController: gameController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.back:
                        gameController.scoreAmount -= levelScore
                        gameController.backButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.refersh:
                        gameController.scoreAmount -= levelScore
                        gameController.startGameButtonPressed(level: level)
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default:
                        guard let name = node.name else { return }
                        if name.contains(Resources.Tiles.background) {
                            if let name = node.name {
                                if let (row, col) = getTilePosition(with: name) {
                                    dotsAnimation(row: row, col: col)
                                    findMatches(row: row, col: col)
                                }
                            }
                        }
                }
                if isGameOver() == 0 {
                    let run = SKAction.run {
                        self.gameController.gameOver(isWin: true, level: self.level, levelScore: self.levelScore)
                    }
                    let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.3), run])
                    view?.scene?.run(sequence)
                } else if isGameOver() == 1 {
                    let run = SKAction.run {
                        self.gameController.scoreAmount -= self.levelScore
                        self.gameController.gameOver(isWin: false, level: self.level, levelScore: self.levelScore)
                    }
                    let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.3), run])
                    view?.scene?.run(sequence)
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.game + String(level))
        setupTopAndBotUI()
        setupBackButton()
        setupRefreshButton()
        setupTileMatrix()
        setTilesBackground()
        setTitleAndSetupLevel()
        setTiles()
    }
    
    private func dotsAnimation(row: Int, col: Int) {
        for i in 0..<tilesBackground.count {
            for j in 0..<tilesBackground[0].count {
                if tilesBackground[i][j] == tilesBackground[i][col] || tilesBackground[i][j] == tilesBackground[row][j] {
                    if level == 2 {
                        if i == 0 {
                            if j == 5 || j == 0 {
                                continue
                            }
                        }
                        if i == 3 {
                            if j == 0 || j == 5 {
                                continue
                            }
                        }
                    } else if level == 5 {
                        if i == 2 {
                            if j == 1 || j == 2 || j == 3 || j == 4 {
                                continue
                            }
                        }
                        if i == 3 {
                            if j == 2 || j == 3 {
                                continue
                            }
                        }
                    }
                    
                    let dot = SKSpriteNode(imageNamed: Resources.Elements.dot)
                    dot.zPosition = 1
                    dot.position = CGPoint(x: tilesBackground[i][j].frame.midX, y: tilesBackground[i][j].frame.midY)
                    dot.setScale(0.1)
                    addChild(dot)
                    let scaleUpAction = SKAction.scale(to: 1.0, duration: 0.2)
                    let scaleDownAction = SKAction.scale(to: 0.1, duration: 0.2)
                    let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
                    let sequence = SKAction.sequence([scaleUpAction, scaleDownAction, fadeOutAction, SKAction.removeFromParent()])
                    dot.run(sequence)
                }
            }
        }
    }
    
    private func isGameOver() -> Int {
        var tilesLeft = 0
        for i in 0..<rowCount {
            for j in 0..<colCount {
                if tiles[i][j].name != nil {
                    tilesLeft += 1
                }
            }
        }
        if tilesLeft == 0 {
            return 0
        } else if tilesLeft == 1 {
            return 1
        }
        return 2
    }
    
    private func setTilesBackground() {
        guard let size = SKSpriteNode(imageNamed: Resources.Tiles.background).texture?.size() else { return }
        
        let totalWidth = CGFloat(colCount) * size.width + CGFloat(colCount - 1) * spacing
        let totalHeight = CGFloat(rowCount) * size.height + CGFloat(rowCount - 1) * spacing
        
        let startX = frame.midX - totalWidth/2 + size.width/2
        let startY = frame.midY + totalHeight/2 - size.height/2
        
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let tile = SKSpriteNode(imageNamed: Resources.Tiles.background)
                tile.name = Resources.Tiles.background + String(row) + String(col)
                let x = startX + CGFloat(col) * (size.width + spacing)
                let y = startY - CGFloat(row) * (size.height + spacing)
                tile.position = CGPoint(x: x, y: y)
                tilesBackground[row][col] = tile
                addChild(tile)
            }
        }

    }
    
    private func setTitleAndSetupLevel() {
        var image = String()
        
        if level == 1 {
            image = Resources.Elements.title + String(1)
        } else if level == 2 {
            correctMatrix(row: [0,0,rowCount-1,rowCount-1], col: [0,colCount-1,0,colCount-1])
            image = Resources.Elements.title + String(2)
        } else if level == 5 {
            correctMatrix(row: [2,2,2,2], col: [1,2,3,4])
            correctMatrix(row: [3,3], col: [2,3])
            image = Resources.Elements.title + String(3)
        } else {
            image = Resources.Elements.title + String(3)
        }
        
        let title = SKSpriteNode(imageNamed: image)
        let middleElement = tilesBackground[0][(colCount/2)-1]
        guard let size = title.texture?.size() else { return }
        if level == 1 {
            title.size = CGSize(width: size.width * 0.85, height: size.height * 0.85)
        } else {
            title.size = CGSize(width: size.width + 4, height: size.height + 4)
        }
        title.zPosition = 1
        title.position = CGPoint(x: frame.midX, y: middleElement.frame.maxY + (title.frame.height / 2) + spacing)
        addChild(title)
    }
    
    private func findMatches(row: Int, col: Int) {
        var leftElement: Element?
        var rightElement: Element?
        var upElement: Element?
        var downElement: Element?
        
        // left
        for c in (0..<col).reversed() {
            let element = tiles[row][c]
            if let name = element.name {
                leftElement = Element(name: name, position: (row, c), direction: .left)
                break
            }
        }
        
        // right
        for c in (col+1)..<colCount {
            let element = tiles[row][c]
            if let name = element.name {
                rightElement = Element(name: name, position: (row, c), direction: .right)
                break
            }
        }
        
        // up
        for r in (0..<row).reversed() {
            let element = tiles[r][col]
            if let name = element.name {
                upElement = Element(name: name, position: (r, col), direction: .up)
                break
            }
        }
        
        // down
        for r in (row+1)..<rowCount {
            let element = tiles[r][col]
            if let name = element.name {
                downElement = Element(name: name, position: (r, col), direction: .down)
                break
            }
        }
        
        compareMatches([leftElement, rightElement, downElement, upElement])
    }
    
    private func compareMatches(_ elements: [Element?]) {
        let validElements = elements.compactMap { $0 }
        guard validElements.count >= 2 else { return }
        
        for i in 0..<validElements.count - 1 {
            for j in i+1..<validElements.count {
                let element1 = validElements[i]
                let element2 = validElements[j]
                
                if element1.name == element2.name {
                    removeMatchedTilesAndAddScore(first: element1, second: element2)
                }
            }
        }
    }
    
    private func removeMatchedTilesAndAddScore(first: Element, second: Element) {
        if tiles[first.position.0][first.position.1].name != nil && tiles[second.position.0][second.position.1].name != nil {
            levelScore += 200
        } else if tiles[first.position.0][first.position.1].name != nil {
            levelScore += 100
        } else if tiles[second.position.0][second.position.1].name != nil {
            levelScore += 100
        }
        
        animateBounceAndDisappear(for: first)
        animateBounceAndDisappear(for: second)
    }
    
    private func animateBounceAndDisappear(for element: Element) {
        let tile = tiles[element.position.0][element.position.1]
        
        let physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        physicsBody.isDynamic = true
        physicsBody.friction = 0.2
        physicsBody.restitution = 0.8
        tile.physicsBody = physicsBody

        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeOutAction, removeAction])
        tile.run(sequence)

        var force = CGVector()
        switch element.direction {
            case .right:
                 force = CGVector(dx: 500, dy: 500)
            case .left:
                force = CGVector(dx: -500, dy: 500)
            case .up:
                force = CGVector(dx: 0, dy: 1000)
            case .down:
                force = CGVector(dx: 0, dy: -500)
        }
        physicsBody.applyForce(force)
        
        tile.run(sequence)
        tile.name = nil
    }
    
    
    private func getTilePosition(with backgroundName: String) -> (Int, Int)? {
        var name = backgroundName
        guard let col = name.popLast() else { return nil}
        guard let row = name.last else { return nil }
        
        if let digitCol = Int(String(col)), let digitRow = Int(String(row)) {
            return (digitRow, digitCol)
        } else {
            return nil
        }
    }
    
    private func correctMatrix(row: [Int], col: [Int]) {
        for i in row {
            for j in col {
                tilesBackground[i][j].removeFromParent()
            }
        }
    }
    
    private func setupTileMatrix() {
        switch level {
            case 1:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 5), count: 3)
                
            case 2:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 4)
            case 3:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            case 4:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            case 5:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            default: break
        }
    }
    
    private func setTile(named: String, position: [Int]) {
        guard let first = position.first, let second = position.last else { return }
        let tile = SKSpriteNode(imageNamed: named)
        tile.name = named
        tile.zPosition = 2
        if let size = tile.texture?.size() {
            tile.size = CGSize(width: size.width * 0.8, height: size.height * 0.8)
        }
        tile.position = CGPoint(x: tilesBackground[first][second].frame.midX, y: tilesBackground[first][second].frame.midY)
        
        tiles[first][second] = tile
        addChild(tile)
    }
    
    private func setTiles() {
        switch level {
            case 1:
                setTile(named: Resources.Tiles.diamond, position: [0,0])
                setTile(named: Resources.Tiles.diamond, position: [0,4])
                
                setTile(named: Resources.Tiles.clover, position: [1,0])
                setTile(named: Resources.Tiles.clover, position: [2,0])
                setTile(named: Resources.Tiles.clover, position: [1,4])
                setTile(named: Resources.Tiles.clover, position: [2,4])
                
                setTile(named: Resources.Tiles.horseshoe, position: [2,1])
                setTile(named: Resources.Tiles.horseshoe, position: [2,3])
                
                setTile(named: Resources.Tiles.ring, position: [0,2])
                setTile(named: Resources.Tiles.ring, position: [1,1])
                setTile(named: Resources.Tiles.ring, position: [1,3])
                setTile(named: Resources.Tiles.ring, position: [2,2])
                
                setTile(named: Resources.Tiles.seven, position: [0,1])
                setTile(named: Resources.Tiles.seven, position: [0,3])
            case 2:
                setTile(named: Resources.Tiles.ring, position: [0,2])
                setTile(named: Resources.Tiles.ring, position: [0,4])
                
                setTile(named: Resources.Tiles.diamond, position: [0,3])
                setTile(named: Resources.Tiles.diamond, position: [3,1])
                
                setTile(named: Resources.Tiles.horseshoe, position: [1,1])
                setTile(named: Resources.Tiles.horseshoe, position: [1,3])
                setTile(named: Resources.Tiles.horseshoe, position: [2,0])
                setTile(named: Resources.Tiles.horseshoe, position: [3,4])
                
                setTile(named: Resources.Tiles.seven, position: [1,2])
                setTile(named: Resources.Tiles.seven, position: [2,1])
                setTile(named: Resources.Tiles.seven, position: [2,3])
                setTile(named: Resources.Tiles.seven, position: [3,2])
                
                setTile(named: Resources.Tiles.clover, position: [1,4])
                setTile(named: Resources.Tiles.clover, position: [2,5])
            case 3:
                setTile(named: Resources.Tiles.diamond, position: [0,0])
                setTile(named: Resources.Tiles.diamond, position: [0,3])
                setTile(named: Resources.Tiles.diamond, position: [1,2])
                setTile(named: Resources.Tiles.diamond, position: [3,2])
                setTile(named: Resources.Tiles.diamond, position: [4,0])
                setTile(named: Resources.Tiles.diamond, position: [4,3])
                
                setTile(named: Resources.Tiles.clover, position: [0,1])
                setTile(named: Resources.Tiles.clover, position: [0,4])
                setTile(named: Resources.Tiles.clover, position: [1,5])
                setTile(named: Resources.Tiles.clover, position: [2,2])
                setTile(named: Resources.Tiles.clover, position: [3,5])
                setTile(named: Resources.Tiles.clover, position: [4,1])
                setTile(named: Resources.Tiles.clover, position: [4,4])
                
                setTile(named: Resources.Tiles.ring, position: [0,2])
                setTile(named: Resources.Tiles.ring, position: [1,0])
                setTile(named: Resources.Tiles.ring, position: [1,3])
                setTile(named: Resources.Tiles.ring, position: [3,0])
                setTile(named: Resources.Tiles.ring, position: [3,3])
                setTile(named: Resources.Tiles.ring, position: [4,2])
                
                setTile(named: Resources.Tiles.horseshoe, position: [1,1])
                setTile(named: Resources.Tiles.horseshoe, position: [1,4])
                setTile(named: Resources.Tiles.horseshoe, position: [2,5])
                setTile(named: Resources.Tiles.horseshoe, position: [3,1])
                setTile(named: Resources.Tiles.horseshoe, position: [3,4])
                
                setTile(named: Resources.Tiles.seven, position: [0,5])
                setTile(named: Resources.Tiles.seven, position: [4,5])
            case 4:
                setTile(named: Resources.Tiles.diamond, position: [0,0])
                setTile(named: Resources.Tiles.diamond, position: [0,4])
                
                setTile(named: Resources.Tiles.clover, position: [0,2])
                setTile(named: Resources.Tiles.clover, position: [1,1])
                setTile(named: Resources.Tiles.clover, position: [1,3])
                setTile(named: Resources.Tiles.clover, position: [2,3])
                setTile(named: Resources.Tiles.clover, position: [3,4])
                setTile(named: Resources.Tiles.clover, position: [4,2])
                setTile(named: Resources.Tiles.clover, position: [4,5])
                
                setTile(named: Resources.Tiles.ring, position: [0,3])
                setTile(named: Resources.Tiles.ring, position: [1,4])
                
                setTile(named: Resources.Tiles.horseshoe, position: [0,5])
                setTile(named: Resources.Tiles.horseshoe, position: [2,0])
                setTile(named: Resources.Tiles.horseshoe, position: [2,2])
                setTile(named: Resources.Tiles.horseshoe, position: [2,4])
                setTile(named: Resources.Tiles.horseshoe, position: [3,5])
                
                setTile(named: Resources.Tiles.seven, position: [2,1])
                setTile(named: Resources.Tiles.seven, position: [3,0])
                setTile(named: Resources.Tiles.seven, position: [3,3])
                setTile(named: Resources.Tiles.seven, position: [4,1])
            case 5:
                setTile(named: Resources.Tiles.horseshoe, position: [0,0])
                setTile(named: Resources.Tiles.horseshoe, position: [3,0])
                
                setTile(named: Resources.Tiles.clover, position: [0,1])
                setTile(named: Resources.Tiles.clover, position: [1,0])
                setTile(named: Resources.Tiles.clover, position: [1,2])
                setTile(named: Resources.Tiles.clover, position: [3,4])
                setTile(named: Resources.Tiles.clover, position: [4,1])
                setTile(named: Resources.Tiles.clover, position: [4,5])
                
                setTile(named: Resources.Tiles.diamond, position: [0,4])
                setTile(named: Resources.Tiles.diamond, position: [1,5])
                
                setTile(named: Resources.Tiles.ring, position: [0,5])
                setTile(named: Resources.Tiles.ring, position: [1,3])
                setTile(named: Resources.Tiles.ring, position: [3,5])
                
                setTile(named: Resources.Tiles.seven, position: [3,1])
                setTile(named: Resources.Tiles.seven, position: [4,0])
                setTile(named: Resources.Tiles.seven, position: [4,2])
                setTile(named: Resources.Tiles.seven, position: [4,4])
            default: break
        }
    }
}
