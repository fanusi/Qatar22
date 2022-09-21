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
        
            let headers = [
                "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
            ]

            //World Cup = 1; Jupiler Pro League = 144
            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=144&season=2022")! as URL,
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
                        print("Counter")
                        print(niveau1.response.count)
                    
                        let start = 0
                        let end = niveau1.response.count - 1
                        
                        // Number of fixtures
                        
                        for n in start...end {
                            
                            let newFixture =  Match(context: self.context)
                
                            newFixture.venue = String(niveau1.response[n].fixture.venue.name)
                            //newFixture.timing = Date(niveau1.response1[n].fixture.date)
                            newFixture.timing = Date()
                            newFixture.team1 = String(niveau1.response[n].teams.home.name)
                            newFixture.team2 = String(niveau1.response[n].teams.away.name)
                            newFixture.goals1 = Int64(niveau1.response[n].goals.home)
                            newFixture.goals2 = Int64(niveau1.response[n].goals.away)
                            newFixture.logo1 = String(niveau1.response[n].teams.home.logo)
                            newFixture.logo2 = String(niveau1.response[n].teams.away.logo)
                                
                            FixturesA.append(newFixture)
                            
                        }
                    
                            
                    } catch {
                        
                        debugPrint(error)
                    }
                        
                }
                
                DispatchQueue.main.async() {
                    self.tableView1.refreshControl?.endRefreshing()
                    self.tableView1.reloadData()
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
                        print("Counter")
                        print(niveau1.response.count)
                    
                        let start = 0
                        let end = niveau1.response.count - 1
                        
                        // Number of fixtures
                        
                        if end >= 0 {
                        // Condition that there are observations in API call (important for live games)
                            
                            for n in start...end {
                                
                                let newFixture =  Match(context: self.context)
                    
                                newFixture.venue = String(niveau1.response[n].fixture.venue.name)
                                //newFixture.timing = Date(niveau1.response1[n].fixture.date)
                                newFixture.timing = Date()
                                newFixture.team1 = String(niveau1.response[n].teams.home.name)
                                newFixture.team2 = String(niveau1.response[n].teams.away.name)
                                newFixture.goals1 = Int64(niveau1.response[n].goals.home)
                                newFixture.goals2 = Int64(niveau1.response[n].goals.away)
                                newFixture.logo1 = String(niveau1.response[n].teams.home.logo)
                                newFixture.logo2 = String(niveau1.response[n].teams.away.logo)
                                    
                                LiveGamesA.append(newFixture)
                                //print(LiveGamesA[n].team1 ?? "")
                                
                            }
                            
                        }
                            
                    } catch {
                        
                        debugPrint(error)
                    }
                        
                }
                
                DispatchQueue.main.async() {
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
            UpperBarLabel12.text = LiveGamesA[0].team1
            UpperBarLabel13.text = String(LiveGamesA[0].goals1)
            UpperBarLabel14.text = LiveGamesA[0].venue
            UpperBarLabel15.text = LiveGamesA[0].team2
            UpperBarLabel16.text = String(LiveGamesA[0].goals2)
            
            if LiveGamesA.count == 1 {
                
                UpperBarLabel21.text = ""
                UpperBarLabel22.text = ""
                UpperBarLabel23.text = ""
                UpperBarLabel24.text = ""
                UpperBarLabel25.text = ""
                UpperBarLabel26.text = ""
                
                
            } else {
                
                UpperBarLabel21.text = ""
                UpperBarLabel22.text = LiveGamesA[1].team1
                UpperBarLabel23.text = String(LiveGamesA[1].goals1)
                UpperBarLabel24.text = LiveGamesA[1].venue
                UpperBarLabel25.text = LiveGamesA[1].team2
                UpperBarLabel26.text = String(LiveGamesA[1].goals2)
                
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
                    
            for i in 0...pr - 1 {
                
                // Loop players
                
                let newArrayFixtures = [Match(context: self.context)]
                PronosB.append(newArrayFixtures)
                
                PronosB[i][0].user = gebruikers[1 + ga * i]
                //PronosB[i][0].fixture_ID = FixturesA[0].fixture_ID
                //PronosB[i][0].round = FixturesA[0].round
                PronosB[i][0].goals1 = Int64((worksheet.data?.rows[1 + ga * i].cells[4].value)!)!
                PronosB[i][0].goals2 = Int64((worksheet.data?.rows[1 + ga * i].cells[5].value)!)!
                PronosB[i][0].team1 = homeTeams[1 + ga * i]
                PronosB[i][0].team2 = awayTeams[1 + ga * i]
                
                for n in 1...ga - 1 {
                    
                    // Loop games
                    let newFixture = Match(context: self.context)
                    newFixture.user = gebruikers[(n + 1) + ga * i]
                    //newFixture.fixture_ID = PronosA[n].fixture_ID
                    //newFixture.round = PronosA[n].round
                    newFixture.goals1 = Int64((worksheet.data?.rows[(n + 1) + ga * i].cells[4].value)!)!
                    newFixture.goals2 = Int64((worksheet.data?.rows[(n + 1) + ga * i].cells[5].value)!)!
                    newFixture.team1 = homeTeams[(n + 1) + ga * i]
                    newFixture.team2 = awayTeams[(n + 1) + ga * i]
                    PronosB[i].append(newFixture)
                    
                }
                
            }
            
          }
        }
    }
    
}
