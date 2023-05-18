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
        static let win = "winBackground"
        static let lose = "loseBackground"
        static let achivements = "achivementBackground"
        static let store = "storeBackground"
        static let lottery = "lotteryBackground"
        static let game = "gameBackground"
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
        static let siren = "sirenButton"
        static let triton = "tritonButton"
        static let ceratiidae = "ceratiidaeButton"
        static let kraken = "krakenButton"
        static let refersh = "refreshButton"
        static let `continue` = "continueButton"
        static let restart = "restartButton"
    }
    
    enum Elements {
        static let loading = "loadingElement"
        static let score = "middleElement"
        static let stars = "stars"
        static let bwStars = "bwStars"
        static let level = "level"
        static let closedLevel = "level6"
        static let closedSeashell = "closedSeashell"
        static let win = "winCongrats"
        static let lightEffect = "lightEffect"
        static let openSeashell = "openSeashell"
        static let title = "titleLevel"
    }
    
    enum Achivmenets {
        enum DictionaryKeys {
            static let background = "background"
            static let cup = "cup"
            static let heart = "heart"
            static let shield = "shield"
            static let ring = "ring"
            static let moneyBag = "moneyBag"
        }
        
        enum Images {
            static let background = "achivementBackground"
            static let cup = "cupAchivement"
            static let heart = "heartAchivement"
            static let shield = "shieldAchivement"
            static let ring = "ringAchivement"
            static let moneyBag = "moneyBagAchivement"
            static let pureCup = "pureCupAchivement"
            static let pureHeart = "pureHeartAchivement"
            static let pureShield = "pureShieldAchivement"
            static let pureRing = "pureRingAchivement"
            static let pureMoneyBag = "pureMoneyBagAchivement"
        }
    }
    
    enum Tiles {
        static let background = "tileBackground"
        static let clover = "cloverTile"
        static let diamond = "diamondTile"
        static let horseshoe = "horseshoeTile"
        static let ring = "ringTile"
        static let seven = "sevenTile"
    }
    
    enum Avatars {
        static let siren = "sirenAvatar"
        static let triton = "tritonAvatar"
        static let ceratiidae = "ceratiidaeAvatar"
        static let kraken = "krakenAvatar"
    }
    
    enum Fonts {
        static let EvilEmpire_Regular = "EvilEmpire"
    }
    
    enum Colors {
        static let blue = "AccentColor"
    }
    
    enum UserDefaultsKeys {
        static let gameSetups = "gameSetups"
    }
}
