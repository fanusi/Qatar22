//
//  Scores.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 24/09/2022.
//

import Foundation

public class Scores {
    
    var user: String
    var punten: Int
    var index: Int
    var ranking: Int
    //var punten_last: String
    
    init(user: String, punten: Int = 0, index: Int, ranking: Int = 0) {
        
        self.user = user
        self.punten = punten
        self.index = index
        self.ranking = ranking
        
    }
    
}

//public class statistiek {
//
//    var punten: Int
//    var user: String
//
//
//    init(user: String, punten: Int = 0) {
//
//        self.user = user
//        self.punten = punten
//
//    }
//
//}
