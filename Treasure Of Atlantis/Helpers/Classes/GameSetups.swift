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
    var currentLevel: Int {
        if isLevelCompleted(5) {
            return 5
        } else if isLevelCompleted(4) {
            return 4
        } else if isLevelCompleted(3) {
            return 3
        } else if isLevelCompleted(2) {
            return 2
        } else {
            return 1
        }
    }
    
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
    
    func getAchivementForLevel(_ level: Int) -> String {
        switch level {
            case 1:
                return Resources.Achivmenets.Images.pureHeart
            case 2:
                return Resources.Achivmenets.Images.pureShield
            case 3:
                return Resources.Achivmenets.Images.pureRing
            case 4:
                return Resources.Achivmenets.Images.pureCup
            case 5:
                return Resources.Achivmenets.Images.pureMoneyBag
            default:
                return ""
        }
    }
    
    private func isLevelCompleted(_ level: Int) -> Bool {
        if isLevelCompleted[level] ?? false {
            return true
        }
        return false
    }
    
    private func achivementsUpdate() {
        if isLevelCompleted(1) {
            achivements[Resources.Achivmenets.DictionaryKeys.heart] = true
        } else if isLevelCompleted(2) {
            achivements[Resources.Achivmenets.DictionaryKeys.shield] = true
        } else if isLevelCompleted(3) {
            achivements[Resources.Achivmenets.DictionaryKeys.ring] = true
        } else if isLevelCompleted(4) {
            achivements[Resources.Achivmenets.DictionaryKeys.cup] = true
        } else if isLevelCompleted(5) {
            achivements[Resources.Achivmenets.DictionaryKeys.moneyBag] = true
        }
    }
}
