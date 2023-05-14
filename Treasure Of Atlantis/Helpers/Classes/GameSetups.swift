//
//  GameSetups.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

class GameSetups: Codable {
    var scoreAmount: Int
    var avatar: String
    var isLevelCompleted: [Int:Bool]
    
    init() {
        scoreAmount = 0
        avatar = Resources.Avatars.siren
        isLevelCompleted = [1:false,
                            2:false,
                            3:false,
                            4:false,
                            5:false]
    }
    
    init(scoreAmount: Int, avatar: String, isLevelCompleted: [Int:Bool]) {
        self.scoreAmount = scoreAmount
        self.avatar = avatar
        self.isLevelCompleted = isLevelCompleted
    }
}
