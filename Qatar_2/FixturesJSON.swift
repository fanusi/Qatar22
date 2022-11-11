//
//  FixturesJSON.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 16/09/2022.
//

import Foundation

struct response1: Codable {
    var response: [fixture]
}

struct fixture: Codable {
    var fixture: fixture_s
    var league: league_s
    var teams: teams_s
    var goals: goals_s
    var score: score_s
    
    enum CodingKeys: String, CodingKey {
       case fixture
       case league
       case teams
       case goals
       case score
   }
       
   // The Initializer function from Decodable
   init(from decoder: Decoder) throws {
       // 1 - Container
       let values = try decoder.container(keyedBy: CodingKeys.self)
       
       // 2 - Normal Decoding
       fixture = try values.decode(fixture_s.self, forKey: .fixture)
       league = try values.decode(league_s.self, forKey: .league)
       teams =  try values.decode(teams_s.self, forKey: .teams)
       goals =  try values.decode(goals_s.self, forKey: .goals)
       score =  try values.decode(score_s.self, forKey: .score)
       
   }
}

struct fixture_s: Codable {
    
    var timestamp: Int
    var venue: venue_s
    var status: status_s
    
    enum CodingKeys: String, CodingKey {
           case timestamp
           case venue
           case status
       }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2 - Normal Decoding
        venue = try values.decode(venue_s.self, forKey: .venue)
        status = try values.decode(status_s.self, forKey: .status)
        
        // 3 - Conditional Decoding
        if var timestamp =  try values.decodeIfPresent(Int.self, forKey: .timestamp) {
            self.timestamp = timestamp
        } else {
            self.timestamp = 0
        }
        
    }
    
}

struct venue_s: Codable {
    
    var name: String
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case city
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        // 3 - Conditional Decoding
        if var name =  try values.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = "-"
        }

        if var city =  try values.decodeIfPresent(String.self, forKey: .city) {
            self.city = city
        } else {
            self.city = "-"
        }
        
    }
    
}

struct status_s: Codable {
    
    var long: String
    var short: String
    var elapsed: Double
    
    enum CodingKeys: String, CodingKey {
        case long
        case short
        case elapsed
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var long =  try values.decodeIfPresent(String.self, forKey: .long) {
            self.long = long
        } else {
            self.long = "-"
        }

        if var short =  try values.decodeIfPresent(String.self, forKey: .short) {
            self.short = short
        } else {
            self.short = "-"
        }
        
        if var elapsed =  try values.decodeIfPresent(Double.self, forKey: .elapsed) {
            self.elapsed = elapsed
        } else {
            self.elapsed = 0
        }
        
    }
    
}

struct league_s: Codable {
    
    var logo: String
    var round: String
    
    enum CodingKeys: String, CodingKey {
           case logo
           case round
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var logo =  try values.decodeIfPresent(String.self, forKey: .logo) {
            self.logo = logo
        } else {
            self.logo = "-"
        }
        
        if var round =  try values.decodeIfPresent(String.self, forKey: .round) {
            self.round = round
        } else {
            self.round = "-"
        }
        
    }
    
}

struct teams_s: Codable {

    var home: home_s
    var away: away_s
    
    enum CodingKeys: String, CodingKey {
           case home
           case away

    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2 - Normal Decoding
        home = try values.decode(home_s.self, forKey: .home)
        away = try values.decode(away_s.self, forKey: .away)

    }
    
}

struct home_s: Codable {
    
    var name: String
    var logo: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case logo
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        // 3 - Conditional Decoding
        if var name =  try values.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = "-"
        }

        if var logo =  try values.decodeIfPresent(String.self, forKey: .logo) {
            self.logo = logo
        } else {
            self.logo = "-"
        }
        
    }
}

struct away_s: Codable {
    
    var name: String
    var logo: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case logo
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        // 3 - Conditional Decoding
        if var name =  try values.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = "-"
        }

        if var logo =  try values.decodeIfPresent(String.self, forKey: .logo) {
            self.logo = logo
        } else {
            self.logo = "-"
        }
        
    }

}

struct score_s: Codable {

    var halftime: halftime_s
    var fulltime: fulltime_s
    var extratime: extratime_s

    
    enum CodingKeys: String, CodingKey {
           case halftime
           case fulltime
           case extratime
       }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2 - Normal Decoding
        halftime = try values.decode(halftime_s.self, forKey: .halftime)
        fulltime = try values.decode(fulltime_s.self, forKey: .fulltime)
        extratime = try values.decode(extratime_s.self, forKey: .extratime)
        
    }
    
}

struct halftime_s: Codable {
    
    var home: Int
    var away: Int
    
    enum CodingKeys: String, CodingKey {
           case home
           case away
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var home =  try values.decodeIfPresent(Int.self, forKey: .home) {
            self.home = home
        } else {
            self.home = -999
        }
        
        if var away =  try values.decodeIfPresent(Int.self, forKey: .away) {
            self.away = away
        } else {
            self.away = -999
        }
        
    }
    
}

struct fulltime_s: Codable {
    
    var home: Int
    var away: Int
    
    enum CodingKeys: String, CodingKey {
           case home
           case away
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var home =  try values.decodeIfPresent(Int.self, forKey: .home) {
            self.home = home
        } else {
            self.home = -999
        }
        
        if var away =  try values.decodeIfPresent(Int.self, forKey: .away) {
            self.away = away
        } else {
            self.away = -999
        }
        
    }
    
}

struct extratime_s: Codable {
    
    var home: Int
    var away: Int
    
    enum CodingKeys: String, CodingKey {
           case home
           case away
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var home =  try values.decodeIfPresent(Int.self, forKey: .home) {
            self.home = home
        } else {
            self.home = -999
        }
        
        if var away =  try values.decodeIfPresent(Int.self, forKey: .away) {
            self.away = away
        } else {
            self.away = -999
        }
        
    }
}
    
struct goals_s: Codable {

    var home: Int
    var away: Int
    
    enum CodingKeys: String, CodingKey {
           case home
           case away
    }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // 3 - Conditional Decoding
        if var home =  try values.decodeIfPresent(Int.self, forKey: .home) {
            self.home = home
        } else {
            self.home = -999
        }
        
        if var away =  try values.decodeIfPresent(Int.self, forKey: .away) {
            self.away = away
        } else {
            self.away = -999
        }
        
    }
    
}






