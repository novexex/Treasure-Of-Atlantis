//
//  Enum.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

enum Resources {
    enum Backgrounds {
        static let splash = "splashBackground"
        static let menu = "menuBackground"
        static let choosingLevel = "choosingLevelBackground"
        static let win = "winBackgrond"
        static let lose = "loseBackground"
    }
    
    enum Buttons {
        static let achivements = "achivementsButton"
        static let hermesGame = "hermesGameButton"
        static let store = "storeButton"
        static let left = "leftButton"
        static let right = "rightButton"
        static let start = "startButton"
        static let lottery = "hermesGameButton"
        static let policy = "privatePolicyButton"
        static let shield = "shieldButton"
        static let back = "backButton"
        static let questionMark = "questionMarkButton"
        static let miniStartButton = "miniStartButton"
    }
    
    enum Elements {
        static let loading = "loadingElement"
        static let score = "middleElement"
        static let stars = "stars"
        static let bwStars = "bwStars"
        static let firstLevel = "firstLevel"
        static let secondLevel = "secondLevel"
        static let thirdLevel = "thirdLevel"
        static let fourthLevel = "fourthLevel"
        static let fifthLevel = "fifthLevel"
        static let bwLevel = "bwLevel"
    }
    
    enum Avatars {
        static let siren = "sirenAvatar"
        static let triton = "tritonAvatar"
    }
    
    enum Fonts {
        static let EvilEmpire_Regular = "EvilEmpire"
    }
    
    enum UserDefaultsKeys {
        static let gameSetups = "gameSetups"
    }
}
