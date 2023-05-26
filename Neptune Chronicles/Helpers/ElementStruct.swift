
struct Element {
    let name: String
    let position: (Int, Int)
    let direction: Direction
}

enum Direction {
    case left
    case right
    case up
    case down
}
