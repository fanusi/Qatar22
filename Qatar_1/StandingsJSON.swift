//
//  FixturesJSON.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 16/09/2022.
//

import Foundation

struct response2: Codable {
    var response: [bridge]
}

struct bridge: Codable {
    var league: league2
}

struct league2: Codable {
    var standings: [standen]
}

struct standen: Codable {
    var standings: [[group]]
}

struct group: Codable {
    
    var rank: Int
    var team: TI
    var all: MP

    
    enum CodingKeys: String, CodingKey {
           case rank
           case team
           case all

       }
       
       // The Initializer function from Decodable
       init(from decoder: Decoder) throws {
           // 1 - Container
           let values = try decoder.container(keyedBy: CodingKeys.self)
           
           // 2 - Normal Decoding
           all = try values.decode(MP.self, forKey: .all)
           team = try values.decode(TI.self, forKey: .team)

           
           // 3 - Conditional Decoding
        
            if var rank =  try values.decodeIfPresent(Int.self, forKey: .rank) {
                self.rank = rank
            } else {
                self.rank = -999
            }
        
        
       }
    
}


struct TI: Codable {
    
    var name: String
    
    enum CodingKeys: String, CodingKey {
           case name
       }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        // 3 - Conditional Decoding
        if var name =  try values.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = "NA"
        }
        
    }
    
}

struct MP: Codable {
    
    var played: Int
    
    enum CodingKeys: String, CodingKey {
           case played
       }
    
    init(from decoder: Decoder) throws {
        // 1 - Container
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        // 3 - Conditional Decoding
        if var played =  try values.decodeIfPresent(Int.self, forKey: .played) {
            self.played = played
        } else {
            self.played = 0
        }
        
    }
    
}
