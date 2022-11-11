//
//  Standings.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 23/09/2022.
//

import Foundation

public class Standings {
    
    var group: Int
    var rank: Int
    var team: String
    var gamesPlayed: Int
    
    init(group: Int, rank: Int, team: String, gamesPlayed: Int) {

        self.group = group
        self.rank = rank
        self.team = team
        self.gamesPlayed = gamesPlayed

    }
    
}
