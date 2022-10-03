//
//  Fixtures.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 16/09/2022.
//

import Foundation

public class Fixtures {
    
    var index: Int
    var venue: String
    var time: String
    var team_1: String
    var goals_1: Int
    var logo_1: String
    var team_2: String
    var goals_2: Int
    var logo_2: String
    var user: String
    var status: String
    var round: String
    var punten: Int
    
    var time_double: Double = 0
    var team_short_1: String = ""
    var team_short_2: String = ""

    
    init(index: Int, venue: String, time: String, team_1: String, goals_1: Int, logo_1: String, team_2: String, goals_2: Int, logo_2: String, user: String = "Tournament", status: String = "", round: String = "", punten: Int = 0) {
        
        self.index = index
        self.venue = venue
        self.time = time
        self.team_1 = team_1
        self.goals_1 = goals_1
        self.logo_1 = logo_1
        self.team_2 = team_2
        self.goals_2 = goals_2
        self.logo_2 = logo_2
        self.user = user
        self.status = status
        self.round = round
        self.punten = punten

    }
    
}
