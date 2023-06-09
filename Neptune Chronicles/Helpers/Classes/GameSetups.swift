//
//  GameSetups.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import Foundation

class GameSetups: Codable {
    var isGuideMode: Bool
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
        isGuideMode = true
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
    
    private func achivementsUpdate() {
        if isLevelCompleted[1] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.heart] = true
        }
        if isLevelCompleted[2] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.shield] = true
        }
        if isLevelCompleted[3] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.ring] = true
        }
        if isLevelCompleted[4] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.cup] = true
        }
        if isLevelCompleted[5] ?? false {
            achivements[Resources.Achivmenets.DictionaryKeys.moneyBag] = true
        }
    }
}
