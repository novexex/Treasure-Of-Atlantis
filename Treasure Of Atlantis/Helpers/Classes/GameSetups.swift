//
//  GameSetups.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

class GameSetups: Codable {
    var scoreAmount: Int
    var avatar: String
    var isLevelCompleted: [Int:Bool] {
        didSet {
            achivementsUpdate()
        }
    }
    private(set) var achivements = [String:Bool]()
    
    init() {
        scoreAmount = 0
        avatar = Resources.Avatars.siren
        isLevelCompleted = [1:false,
                            2:false,
                            3:false,
                            4:false,
                            5:false]
        achivements = [Resources.Achivmenets.DictionaryKeys.heart:false,
                       Resources.Achivmenets.DictionaryKeys.shield:false,
                       Resources.Achivmenets.DictionaryKeys.ring:false,
                       Resources.Achivmenets.DictionaryKeys.cup:false,
                       Resources.Achivmenets.DictionaryKeys.moneyBag:false]
    }
    
    init(scoreAmount: Int, avatar: String, isLevelCompleted: [Int:Bool], achivements: [String:Bool]) {
        self.scoreAmount = scoreAmount
        self.avatar = avatar
        self.isLevelCompleted = isLevelCompleted
        self.achivements = achivements
    }
    
    private func achivementsUpdate() {
        if isLevelCompleted[1] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.heart] = true
        } else if isLevelCompleted[2] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.shield] = true
        } else if isLevelCompleted[3] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.ring] = true
        } else if isLevelCompleted[4] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.cup] = true
        } else if isLevelCompleted[5] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.moneyBag] = true
        }
    }
}
