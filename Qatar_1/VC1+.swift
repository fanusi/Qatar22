//
//  VC1+.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 16/09/2022.
//

import Foundation
import UIKit
import CoreXLSX

extension ViewController1 {
    
    func fixtureParsing () {
        
            FixturesA.removeAll()
        
            print("Start fixture parsing...")
        
            let headers = [
                "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
            ]

            //World Cup = 1; Jupiler Pro League = 144
            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=1&season=2022")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    
                if error == nil && data != nil {
                        
                    let decoder = JSONDecoder()
                        
                do {
                    
                        let niveau1 = try decoder.decode(response1.self, from: data!)
                        print("Items fixtures = \(niveau1.response.count)")
                    
                        let start = 0
                        let end = 63
                        
                        // Number of fixtures
                        
                        for n in start...end {
                            
                            if n < niveau1.response.count {
                                //API entry existing
                                
                                
                                let newFixture =  Fixtures(index: n, venue: String(niveau1.response[n].fixture.venue.name), timing: Date(), team_1: String(niveau1.response[n].teams.home.name), goals_1: Int(niveau1.response[n].goals.home), logo_1: String(niveau1.response[n].teams.home.logo), team_2: String(niveau1.response[n].teams.away.name), goals_2: Int(niveau1.response[n].goals.away), logo_2: String(niveau1.response[n].teams.away.logo), status: niveau1.response[n].fixture.status.short, round: niveau1.response[n].league.round)
                                
                                    FixturesA.append(newFixture)
                                
                            } else {
                            
                                var round: String
                                
                                if n < qf {
                                    round = "Round of 16"
                                } else if n < sf {
                                    round = "Quarter Finals"
                                } else if n < f {
                                    round = "Semi Finals"
                                } else {
                                    round = "Final"
                                }
                                
                                let newFixture =  Fixtures(index: n, venue: "-", timing: Date(), team_1: "-", goals_1: -999, logo_1: "-", team_2: "-", goals_2: -999, logo_2: "-", status: "NS", round: round)
                                
                                    FixturesA.append(newFixture)
                                
                            }
                            
                        }
                    
                            
                    } catch {
                        
                        debugPrint(error)
                    }
                        
                }
                
                DispatchQueue.main.async() {
                    
                    self.initiate()
                    self.tableView1.refreshControl?.endRefreshing()
                    self.tableView1.reloadData()
                    
                }
                                
                })
                    
                dataTask.resume()

        }
    
    func standingParsing () {
                    
                    //Populate standings from FootballAPI
            
                    StandingsA.removeAll()
                    groupsPlayed.removeAll()
                    qual16.removeAll()
        
                    // TEMP
                    qual16 = ["Turkey", "Denmark", "Italy", "Netherlands", "Ukraine", "Sweden", "Belgium", "Germany", "Croatia", "Poland", "France", "Austria", "England", "Portugal", "Spain", "Scotland"]
            
                    let headers = [
                        "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
                    ]

                    let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/standings?season=2022&league=1")! as URL,
                                                            cachePolicy: .useProtocolCachePolicy,
                                                        timeoutInterval: 10.0)
                    request.httpMethod = "GET"
                    request.allHTTPHeaderFields = headers

                    let session = URLSession.shared
                
                    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                        
                        
                    if error == nil && data != nil {
                        
                            
                    let decoder = JSONDecoder()
                            
                    do {
                        
                            let poules: Int = 8
                            let ploegen: Int = 4
                        
                            let niveau2 = try decoder.decode(response2.self, from: data!)
                            
                            for i in 0...poules-1 {
                                
                                
                                var m1: Int = 0
                                
                                
                                for j in 0...ploegen-1 {
                                    
                                    let newStanding = Standings(group: i+1, rank: niveau2.response[0].league.standings[i][j].rank, team: niveau2.response[0].league.standings[i][j].team.name, gamesPlayed: niveau2.response[0].league.standings[i][j].all.played)

                                    
                                    StandingsA.append(newStanding)
                                
                                    m1 = m1 + newStanding.gamesPlayed
                                    //temp
                                    //m1 = m1 + Int.random(in: 0..<4)
                                        
                                }
                                
                                groupsPlayed.append(m1)

                            }
                        
                        } catch {
                            
                            debugPrint(error)
                        }
                            
                    }
                        
                    DispatchQueue.main.async() {
                        
                        self.initiate()
                        //qual16 = calcul.qualbest2()
                        
                    }
                                    
                    })
                        
                    dataTask.resume()
                

            }

    func liveGamesParsing () {
        
            LiveGamesA.removeAll()
        
            let headers = [
                "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?live=all")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    
                if error == nil && data != nil {
                        
                    let decoder = JSONDecoder()
                        
                do {
                    
                        let niveau1 = try decoder.decode(response1.self, from: data!)
                        print("Items live games = \(niveau1.response.count)")
                    
                        let start = 0
                        let end = niveau1.response.count - 1
                        
                        // Number of fixtures
                        
                        if end >= 0 {
                        // Condition that there are observations in API call (important for live games)
                            
                            for n in start...end {
                                
                                //let newFixture =  Match(context: self.context)
                                
                                let newFixture =  Fixtures(index: n, venue: String(niveau1.response[n].fixture.venue.name), timing: Date(), team_1: String(niveau1.response[n].teams.home.name), goals_1: Int(niveau1.response[n].goals.home), logo_1: String(niveau1.response[n].teams.home.logo), team_2: String(niveau1.response[n].teams.away.name), goals_2: Int(niveau1.response[n].goals.away), logo_2: String(niveau1.response[n].teams.away.logo))
                                    
                                LiveGamesA.append(newFixture)
                                //print(LiveGamesA[n].team1 ?? "")
                                
                            }
                            
                        }
                            
                    } catch {
                        
                        debugPrint(error)
                    }
                        
                }
                
                DispatchQueue.main.async() {
                    self.initiate()
                    self.tableView1.refreshControl?.endRefreshing()
                    self.tableView1.reloadData()
                    self.upperBarUpdate()
                }
                                
                })
                    
                dataTask.resume()

        }
    
    func upperBarUpdate() {
        
        if LiveGamesA.count > 0 {
        // Game are ongoing => Live modus
            
            UpperBarLabel11.text = ""
            UpperBarLabel12.text = LiveGamesA[0].team_1
            UpperBarLabel13.text = String(LiveGamesA[0].goals_1)
            UpperBarLabel14.text = LiveGamesA[0].venue
            UpperBarLabel15.text = LiveGamesA[0].team_2
            UpperBarLabel16.text = String(LiveGamesA[0].goals_2)
            
            if LiveGamesA.count == 1 {
                
                UpperBarLabel21.text = ""
                UpperBarLabel22.text = ""
                UpperBarLabel23.text = ""
                UpperBarLabel24.text = ""
                UpperBarLabel25.text = ""
                UpperBarLabel26.text = ""
                
                
            } else {
                
                UpperBarLabel21.text = ""
                UpperBarLabel22.text = LiveGamesA[1].team_1
                UpperBarLabel23.text = String(LiveGamesA[1].goals_1)
                UpperBarLabel24.text = LiveGamesA[1].venue
                UpperBarLabel25.text = LiveGamesA[1].team_2
                UpperBarLabel26.text = String(LiveGamesA[1].goals_2)
                
            }
            
        } else {
        // No games ongoing ==> Next fixture(s) modus
            
            print("Test11")
            
            UpperBarLabel11.text = ""
            UpperBarLabel12.text = ""
            UpperBarLabel13.text = ""
            UpperBarLabel14.text = ""
            UpperBarLabel15.text = ""
            UpperBarLabel16.text = ""
            UpperBarLabel21.text = ""
            UpperBarLabel22.text = ""
            UpperBarLabel23.text = ""
            UpperBarLabel24.text = ""
            UpperBarLabel25.text = ""
            UpperBarLabel26.text = ""
            
            
        }
        
        
    }
    
    func realpronos () {
        
        var gebruikers: [String] = []
        var homeTeams: [String] = []
        var awayTeams: [String] = []
        
        guard let filepath = Bundle.main.path(forResource: "EK 2021 xcode1", ofType: "xlsx") else {

            fatalError("Error n1")
        }

        guard let file = XLSXFile(filepath: filepath) else {
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        }

        for wbk in try! file.parseWorkbooks() {
            for (name, path) in try! file.parseWorksheetPathsAndNames(workbook: wbk) {
            if let worksheetName = name {
              print("This worksheet has a name: \(worksheetName)")
            }

            let worksheet = try! file.parseWorksheet(at: path)
                
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnAStrings = worksheet.cells(atColumns: [ColumnReference("A")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                gebruikers = columnAStrings
    
            }
                
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                homeTeams = columnCStrings
    
            }
            
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnDStrings = worksheet.cells(atColumns: [ColumnReference("D")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                awayTeams = columnDStrings
    
            }
            
            print(gebruikers[0])
            print(gebruikers[1])
            
            PronosB.removeAll()
            StandenA.removeAll()
                    
            for i in 0...pr - 1 {
                
                // Loop players
                
                // Add player to players' standing
                let player_i = Scores(user: gebruikers[1 + ga * i], index: i)
                StandenA.append(player_i)
                
                let newArrayFixtures = [Fixtures]()
                
                PronosB.append(newArrayFixtures)
                
                let fixture =  Fixtures(index: 0, venue: "", timing: Date(), team_1: homeTeams[1 + ga * i], goals_1: Int((worksheet.data?.rows[1 + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[1 + ga * i], goals_2: Int((worksheet.data?.rows[1 + ga * i].cells[5].value)!)!, logo_2: "", user: gebruikers[1 + ga * i])
                
                PronosB[i].append(fixture)
                
                for n in 1...ga - 1 {
                    
                    // Loop games
                    
                    let fixture =  Fixtures(index: n, venue: "", timing: Date(), team_1: homeTeams[(n + 1) + ga * i], goals_1: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[(n + 1) + ga * i], goals_2: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[5].value)!)!, logo_2: "", user: gebruikers[(n + 1) + ga * i])
                    
                    PronosB[i].append(fixture)
                    
                }
                
            }
            
          }
        }
    }
    
    func realpronos_temp () {
    // Used for testing
        
        var gebruikers: [String] = []
        var homeTeams: [String] = []
        var awayTeams: [String] = []
        
        FixturesA.removeAll()
        
        guard let filepath = Bundle.main.path(forResource: "EK 2021 xcode1", ofType: "xlsx") else {

            fatalError("Error n1")
        }

        guard let file = XLSXFile(filepath: filepath) else {
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        }

        for wbk in try! file.parseWorkbooks() {
            for (name, path) in try! file.parseWorksheetPathsAndNames(workbook: wbk) {
            if let worksheetName = name {
              print("This worksheet has a name: \(worksheetName)")
            }

            let worksheet = try! file.parseWorksheet(at: path)
                
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnAStrings = worksheet.cells(atColumns: [ColumnReference("A")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                gebruikers = columnAStrings
    
            }
                
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                homeTeams = columnCStrings
    
            }
            
            if let sharedStrings = try! file.parseSharedStrings() {
              let columnDStrings = worksheet.cells(atColumns: [ColumnReference("D")!])
                .compactMap { $0.stringValue(sharedStrings) }
            
                awayTeams = columnDStrings
    
            }
                    
            for i in 1...1 {
                
                let fixture =  Fixtures(index: 0, venue: "", timing: Date(), team_1: homeTeams[1 + ga * i], goals_1: Int((worksheet.data?.rows[1 + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[1 + ga * i], goals_2: Int((worksheet.data?.rows[1 + ga * i].cells[5].value)!)!, logo_2: "", user: "Tournament")
                
                FixturesA.append(fixture)
                
                for n in 1...ga - 1 {
                    
                    // Loop games
                    
                    let fixture =  Fixtures(index: n, venue: "", timing: Date(), team_1: homeTeams[(n + 1) + ga * i], goals_1: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[(n + 1) + ga * i], goals_2: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[5].value)!)!, logo_2: "", user: "Tournament")
                    
                    FixturesA.append(fixture)
                    
                }
                
            }
            
          }
        }
    }
    
    func test1() {
        
        print("Fixtures \(FixturesA.count)")
        print("PronosB \(PronosB.count)")
        print("StandenA \(StandenA.count)")
        print("StandingsA \(StandingsA.count)")
        
        if FixturesA.count > 0 && PronosB.count > 0 && StandenA.count > 0 && StandingsA.count > 0 {
            
            for i in 0...ga-1 {
                
                print(FixturesA[i].team_1 + " - " + FixturesA[i].team_2)
                print(PronosB[1][i].user)
                print(PronosB[1][i].team_1 + " - " + PronosB[1][i].team_2)
                
            }
            
            for i in 0...StandenA.count - 1 {
                
                print(StandenA[i].user)
                print(StandenA[i].punten)
                
            }
            
            for i in 0...StandingsA.count - 1 {
                
                print(StandingsA[i].group)
                print(StandingsA[i].rank)
                print(StandingsA[i].team)
                
            }
            
        }
        
    }
    
}
