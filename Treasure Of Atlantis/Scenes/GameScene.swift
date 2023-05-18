
import SpriteKit

class GameScene: BaseScene {
    let level: Int
    
    private var tilesBackground = [[SKSpriteNode]]()
    private var tiles = [[SKSpriteNode?]]()
    
    
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
                        gameController.backButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.refersh:
                        gameController.startGameButtonPressed(level: level)
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default:
                        guard let name = node.name else { return }
                        if name.contains(Resources.Tiles.background) {
                            if let name = node.name {
                                if let (row, col) = getTilePosition(with: name) {
                                    findMatches(row: row, col: col)
                                }
                            }
                        }
                }
                if isGameOver() {
                    gameController.gameOver(isWin: true, level: level)
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
    
    private func isGameOver() -> Bool {
        for i in 0..<tiles.count {
            for j in 0..<tiles[0].count {
                if tiles[i][j] != nil {
                    return false
                }
            }
        }
        return true
    }
    
    private func setTilesBackground() {
        let rowCount = tilesBackground.count
        let colCount = tilesBackground[0].count
        let spacing: CGFloat = 3
        
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
        let rowCount = tilesBackground.count
        let colCount = tilesBackground[0].count
        let spacing: CGFloat = 3
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
        let rowCount = tiles.count
        let columnCount = tiles[0].count
        
        var leftElement: Element?
        var rightElement: Element?
        var upElement: Element?
        var downElement: Element?
        
        // left
        for c in (0..<col).reversed() {
            let element = tiles[row][c]
            if let name = element?.name {
                leftElement = Element(name: name, position: (row, c))
                break
            }
        }
        
        // right
        for c in (col+1)..<columnCount {
            let element = tiles[row][c]
            if let name = element?.name {
                rightElement = Element(name: name, position: (row, c))
                break
            }
        }
        
        // up
        for r in (0..<row).reversed() {
            let element = tiles[r][col]
            if let name = element?.name {
                upElement = Element(name: name, position: (r, col))
                break
            }
        }
        
        // down
        for r in (row+1)..<rowCount {
            let element = tiles[r][col]
            if let name = element?.name {
                downElement = Element(name: name, position: (r, col))
                break
            }
        }
        
        compareMatches([leftElement, rightElement, downElement, upElement])
    }
    
    private func compareMatches(_ elements: [Element?]) {
        let validElements = elements.compactMap { $0 }
        
        for i in 0..<validElements.count - 1 {
            for j in i+1..<validElements.count {
                let element1 = validElements[i]
                let element2 = validElements[j]
                
                if element1.name == element2.name {
                    removeMatchedTiles(first: element1, second: element2)
                }
            }
        }
    }
    
    private func removeMatchedTiles(first: Element, second: Element) {
        tiles[first.position.0][first.position.1]?.removeFromParent()
        tiles[second.position.0][second.position.1]?.removeFromParent()
        
        tiles[first.position.0][first.position.1] = nil
        tiles[second.position.0][second.position.1] = nil
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
                tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: 5), count: 3)
            case 2:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 4)
                tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 4)
            case 3:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
                tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            case 4:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
                tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            case 5:
                tilesBackground = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
                tiles = Array(repeating: Array(repeating: SKSpriteNode(), count: 6), count: 5)
            default: break
        }
    }
    
    private func setTile(named: String, position: [Int]) {
        guard let first = position.first, let second = position.last else { return }
        let tile = SKSpriteNode(imageNamed: named)
        tile.name = named
        tile.zPosition = 1
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
