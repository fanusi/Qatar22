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
        
            var Fixtures_temp = [Fixtures]()
            Fixtures_temp.removeAll()
        
            print("Start fixture parsing...")
        
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
                        print("Items fixtures = \(niveau1.response.count)")
                    
                        let start = 0
                        let end = ga-1
                        
                        // Number of fixtures
                        
                        for n in start...end {
                            
                            if n < niveau1.response.count {
                                //API entry existing
                                
                                let timeStamp = Double(niveau1.response[n].fixture.timestamp)
                                let unixTimeStamp: Double = Double(timeStamp) / 1.0
                                let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
                                let dateFormatt = DateFormatter();
                                dateFormatt.dateFormat = "dd/MM  h:mm"
                                let date1 = dateFormatt.string(from: exactDate as Date)
                                
                                
                                let newFixture =  Fixtures(index: n, venue: String(niveau1.response[n].fixture.venue.name), time: date1, team_1: String(niveau1.response[n].teams.home.name), goals_1: Int(niveau1.response[n].goals.home), logo_1: String(niveau1.response[n].teams.home.logo), team_2: String(niveau1.response[n].teams.away.name), goals_2: Int(niveau1.response[n].goals.away), logo_2: String(niveau1.response[n].teams.away.logo), status: niveau1.response[n].fixture.status.short, round: niveau1.response[n].league.round)
                                
                                    newFixture.time_double = timeStamp
                                    newFixture.team_short_1 = shortTeams[newFixture.team_1] ?? ""
                                    newFixture.team_short_2 = shortTeams[newFixture.team_2] ?? ""
                                
                                    Fixtures_temp.append(newFixture)
                                                                
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
                                
                                let newFixture =  Fixtures(index: n, venue: "-", time: "-", team_1: "-", goals_1: -999, logo_1: "-", team_2: "-", goals_2: -999, logo_2: "-", status: "NS", round: round)
                                
                                // Set timing so it is later than all known games
                                newFixture.time_double = 2500000000
                                
                                Fixtures_temp.append(newFixture)
                                
                            }
                            
                        }
                    
                    FixturesA = Fixtures_temp.sorted(by: { ($0.time_double) < ($1.time_double) })
                    
                            
                    } catch {
                        
                        debugPrint(error)
                    }
                        
                }
                
                DispatchQueue.main.async() {
                    
                    self.initiate()
                    self.upperBarUpdate()
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
                        self.upperBarUpdate()
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
            
            // &league=144
            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?live=all&league=144")! as URL,
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
                                
                                let newFixture =  Fixtures(index: n, venue: String(niveau1.response[n].fixture.venue.name), time: "", team_1: String(niveau1.response[n].teams.home.name), goals_1: Int(niveau1.response[n].goals.home), logo_1: String(niveau1.response[n].teams.home.logo), team_2: String(niveau1.response[n].teams.away.name), goals_2: Int(niveau1.response[n].goals.away), logo_2: String(niveau1.response[n].teams.away.logo))
                                
                                newFixture.elapsed = Int(niveau1.response[n].fixture.status.elapsed)
                                newFixture.team_short_1 = shortTeams[newFixture.team_1] ?? ""
                                newFixture.team_short_2 = shortTeams[newFixture.team_2] ?? ""
                                newFixture.short = String(niveau1.response[n].fixture.status.short)
                                    
                                LiveGamesA.append(newFixture)
                                //print(LiveGamesA[n].team_1 ?? "Nothing")
                                
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
                    //self.upcomingGamesParsing()
                    self.upperBarUpdate()
                }
                                
                })
                    
                dataTask.resume()

        }
    
    func upcomingGamesParsing () {
        
            UpcomingGamesA.removeAll()
        
            let headers = [
                "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=144&next=50")! as URL,
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
                        print("Items upcoming games = \(niveau1.response.count)")
                    
                        let start = 0
                        let end = niveau1.response.count - 1
                        
                        // Number of fixtures
                        
                        if end >= 0 {
                        // Condition that there are observations in API call (important for live games)
                            
                            for n in start...end {
                                
                                //let newFixture =  Match(context: self.context)
                                
                                
                                let timeStamp = Double(niveau1.response[n].fixture.timestamp)
                                let unixTimeStamp: Double = Double(timeStamp) / 1.0
                                let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
                                let dateFormatt = DateFormatter();
                                dateFormatt.dateFormat = "dd/MM  h:mm"
                                let date1 = dateFormatt.string(from: exactDate as Date)
                                
                                let newFixture =  Fixtures(index: n, venue: String(niveau1.response[n].fixture.venue.name), time: date1, team_1: String(niveau1.response[n].teams.home.name), goals_1: Int(niveau1.response[n].goals.home), logo_1: String(niveau1.response[n].teams.home.logo), team_2: String(niveau1.response[n].teams.away.name), goals_2: Int(niveau1.response[n].goals.away), logo_2: String(niveau1.response[n].teams.away.logo))
                                    
                                UpcomingGamesA.append(newFixture)
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
                    self.upperBarUpdate2()
                }
                                
                })
                    
                dataTask.resume()

        }
    
    func upperBarUpdate() {
        
            // remove existing views
            removeSV(viewsv: upperBar)
        
            if LiveGamesA.count == 1 {
            // A single game is being played
            print("1 game ongoing")
                
                //upperBar.backgroundColor = .black
                                
                newimage(view1: upperBar, name: LiveGamesA[0].logo_1, x: 0.025, y: 0.05, width: 0.20, height: 0.90)
                
                newlabel(view1: upperBar, x: 0.225, y: 0.05, width: 0.20, height: 0.90, text: LiveGamesA[0].team_short_1, fontsize: 16.0, center: true)
                
                var elaps: String = String(LiveGamesA[0].elapsed) + "'"
                
                print(LiveGamesA[0].short)
                if LiveGamesA[0].short == "HT" {
                    elaps = "HT"
                }
                
                newlabel(view1: upperBar, x: 0.425, y: 0.05, width: 0.15, height: 0.15, text: elaps, fontsize: 14.0, center: true, textcolor: .systemRed)
                
                newlabel(view1: upperBar, x: 0.425, y: 0.20, width: 0.15, height: 0.60, text: String(LiveGamesA[0].goals_1) + " - " + String(LiveGamesA[0].goals_2), fontsize: 16.0, center: true)
                
                newlabel(view1: upperBar, x: 0.575, y: 0.05, width: 0.20, height: 0.90, text: LiveGamesA[0].team_short_2, fontsize: 16.0, center: true)
                
                newimage(view1: upperBar, name: LiveGamesA[0].logo_2, x: 0.775, y: 0.05, width: 0.20, height: 0.90)
                
            } else if LiveGamesA.count > 1 {
            // Two games are being played
            print("2 games ongoing")
                
                //upperBar.backgroundColor = .black
                
                //Game 1
                
                print(LiveGamesA[0].time)

                
                newimage(view1: upperBar, name: LiveGamesA[0].logo_1, x: 0.025, y: 0.10, width: 0.20, height: 0.35)
                
                    //LiveGamesA[0].team_short_1
                
                newlabel(view1: upperBar, x: 0.225, y: 0.05, width: 0.20, height: 0.45, text: LiveGamesA[0].team_short_1, fontsize: 16.0, center: true)
                
                var elaps: String = String(LiveGamesA[0].elapsed) + "'"
                
                print(LiveGamesA[0].short)
                if LiveGamesA[0].short == "HT" {
                    elaps = "HT"
                }

                newlabel(view1: upperBar, x: 0.425, y: 0.025, width: 0.15, height: 0.10, text: elaps, fontsize: 16.0, center: true, textcolor: .systemRed)
                
                newlabel(view1: upperBar, x: 0.425, y: 0.125, width: 0.15, height: 0.30, text: String(LiveGamesA[0].goals_1) + " - " + String(LiveGamesA[0].goals_2), fontsize: 16.0, center: true)
                
                newlabel(view1: upperBar, x: 0.575, y: 0.05, width: 0.20, height: 0.45, text: LiveGamesA[0].team_short_2, fontsize: 16.0, center: true)
                
                newimage(view1: upperBar, name: LiveGamesA[0].logo_2, x: 0.775, y: 0.10, width: 0.20, height: 0.35)
                
                //Game 2
                newimage(view1: upperBar, name: LiveGamesA[1].logo_1, x: 0.025, y: 0.50, width: 0.20, height: 0.35)
                    
                newlabel(view1: upperBar, x: 0.225, y: 0.45, width: 0.20, height: 0.45, text: LiveGamesA[1].team_short_1, fontsize: 16.0, center: true)
                
                var elaps2: String = String(LiveGamesA[1].elapsed) + "'"
                
                print(LiveGamesA[1].short)
                if LiveGamesA[1].short == "HT" {
                    elaps2 = "HT"
                }
                
                newlabel(view1: upperBar, x: 0.425, y: 0.425, width: 0.15, height: 0.10, text: elaps2, fontsize: 16.0, center: true, textcolor: .systemRed)
                
                newlabel(view1: upperBar, x: 0.425, y: 0.525, width: 0.15, height: 0.30, text: String(LiveGamesA[1].goals_1) + " - " + String(LiveGamesA[1].goals_2), fontsize: 16.0, center: true)
                
                newlabel(view1: upperBar, x: 0.575, y: 0.45, width: 0.20, height: 0.45, text: LiveGamesA[1].team_short_2, fontsize: 16.0, center: true)
                
                newimage(view1: upperBar, name: LiveGamesA[1].logo_2, x: 0.775, y: 0.50, width: 0.20, height: 0.35)
                
                
            } else if calcul.fixtures.count > 0  {
            // No games ongoing
            print("No games ongoing")
                
                //upperBar.backgroundColor = .blue
                            
                let thirdGames: [Int] = [32, 34, 36, 38, 40, 42, 44, 46]
                
                print("Last game equals")
                print(calcul.lastgame1)
                
                if thirdGames.contains(calcul.lastgame1 + 1) {
                // If next game is third Group game then there will be two games played at same time
                    
                    //Game 1
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+1].logo_1, x: 0.025, y: 0.10, width: 0.20, height: 0.35)
                    
                    newlabel(view1: upperBar, x: 0.225, y: 0.05, width: 0.20, height: 0.45, text: calcul.fixtures[calcul.lastgame1+1].team_short_1, fontsize: 16.0, center: true)
                    
                    newlabel(view1: upperBar, x: 0.575, y: 0.05, width: 0.20, height: 0.45, text: calcul.fixtures[calcul.lastgame1+1].team_short_2, fontsize: 16.0, center: true)
                    
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+1].logo_2, x: 0.775, y: 0.10, width: 0.20, height: 0.35)
                    
                    //Game 2
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+2].logo_1, x: 0.025, y: 0.50, width: 0.20, height: 0.35)
                        
                    newlabel(view1: upperBar, x: 0.225, y: 0.45, width: 0.20, height: 0.45, text: calcul.fixtures[calcul.lastgame1+2].team_short_1, fontsize: 16.0, center: true)
                    
                    newlabel(view1: upperBar, x: 0.575, y: 0.45, width: 0.20, height: 0.45, text: calcul.fixtures[calcul.lastgame1+2].team_short_2, fontsize: 16.0, center: true)
                    
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+2].logo_2, x: 0.775, y: 0.50, width: 0.20, height: 0.35)
                    
                    //Info
                    
                    newlabel(view1: upperBar, x: 0.425, y: 0, width: 0.15, height: 0.25, text: calcul.fixtures[calcul.lastgame1+1].time, fontsize: 10.0, center: true)
                    
                } else {
                    
                    print("Called")
                    print(calcul.lastgame1+1)
                    print(calcul.fixtures[calcul.lastgame1+1].logo_1)
                    
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+1].logo_1, x: 0.025, y: 0.05, width: 0.20, height: 0.90)
                        
                    newlabel(view1: upperBar, x: 0.225, y: 0.05, width: 0.20, height: 0.90, text: calcul.fixtures[calcul.lastgame1+1].team_short_1, fontsize: 16.0, center: true)
                    
                    newlabel(view1: upperBar, x: 0.425, y: 0.05, width: 0.15, height: 0.30, text: calcul.fixtures[calcul.lastgame1+1].time, fontsize: 12.0, center: true)
                    
                    newlabel(view1: upperBar, x: 0.425, y: 0.70, width: 0.15, height: 0.30, text: calcul.fixtures[calcul.lastgame1+1].round, fontsize: 12.0, center: true)
                    
                    newlabel(view1: upperBar, x: 0.575, y: 0.05, width: 0.20, height: 0.90, text: calcul.fixtures[calcul.lastgame1+1].team_short_2, fontsize: 16.0, center: true)
                    
                    newimage(view1: upperBar, name: calcul.fixtures[calcul.lastgame1+1].logo_2, x: 0.775, y: 0.05, width: 0.20, height: 0.90)
                    
                }
            
            }
            
            //livebar.addSubview(updatebtn)
            //return livebar
        
    }
    
    func upperBarUpdate2() {
         
             // remove existing views
             removeSV(viewsv: upperBar)
         
             if LiveGamesA.count == 1 {
             // A single game is being played
             print("1 game ongoing")
                 
                 upperBar.backgroundColor = .black
                 
                 newlabel(view1: upperBar, x: 0.02, y: 0.4, width: 0.35, height: 0.3, text: LiveGamesA[0].team_1 + " - " + LiveGamesA[0].team_2, fontsize: 16.0, center: false)
                 newlabel(view1: upperBar, x: 0.50, y: 0.4, width: 0.20, height: 0.3, text: String(LiveGamesA[0].goals_1) + " - " + String(LiveGamesA[0].goals_2), fontsize: 16.0, center: true)
                 
                 
             } else if LiveGamesA.count > 1 {
             // Two games are being played
             print("2 games ongoing")
                 
                 upperBar.backgroundColor = .black
                 
                 newlabel(view1: upperBar, x: 0.02, y: 0.15, width: 0.35, height: 0.3, text: LiveGamesA[0].team_1 + " - " + LiveGamesA[0].team_2, fontsize: 14.0, center: false)
                 newlabel(view1: upperBar, x: 0.50, y: 0.15, width: 0.20, height: 0.3, text: String(LiveGamesA[0].goals_1) + " - " + String(LiveGamesA[0].goals_2), fontsize: 14.0, center: true)
                 
                 newlabel(view1: upperBar, x: 0.02, y: 0.5, width: 0.35, height: 0.3, text: LiveGamesA[1].team_1 + " - " + LiveGamesA[1].team_2, fontsize: 14.0, center: false)
                 newlabel(view1: upperBar, x: 0.50, y: 0.5, width: 0.20, height: 0.3, text: String(LiveGamesA[1].goals_1) + " - " + String(LiveGamesA[1].goals_2), fontsize: 14.0, center: true)
                 
             } else if UpcomingGamesA.count > 0 {
                 // No games ongoing
                 print("No games ongoing")
                 
                 upperBar.backgroundColor = .red
                 
                 newlabel(view1: upperBar, x: 0.02, y: 0.15, width: 0.20, height: 0.3, text: UpcomingGamesA[0].round, fontsize: 14.0, center: false)
                 newlabel(view1: upperBar, x: 0.02, y: 0.50, width: 0.20, height: 0.3, text: UpcomingGamesA[0].time, fontsize: 14.0, center: false)
                 newlabel(view1: upperBar, x: 0.30, y: 0.15, width: 0.35, height: 0.3, text: UpcomingGamesA[0].team_1 + " - " + UpcomingGamesA[0].team_2, fontsize: 14.0, center: false)
                 newlabel(view1: upperBar, x: 0.30, y: 0.50, width: 0.35, height: 0.3, text: UpcomingGamesA[1].team_1 + " - " + UpcomingGamesA[1].team_2, fontsize: 14.0, center: false)
                 
             }
         
     }

    
    func newlabel (view1: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, fontsize: CGFloat, center: Bool, textcolor: UIColor = .black) {
        
        let label = UILabel(frame: CGRect(x: view1.frame.width * x, y: view1.frame.height * y, width: view1.frame.width * width, height: view1.frame.height * height))
        if center {
            label.textAlignment = NSTextAlignment.center
        } else {
            label.textAlignment = NSTextAlignment.left
        }
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: fontsize)
//        if textwhite {
//            label.textColor = .white
//        }
        
        label.textColor = textcolor
        
        if textcolor == .black {
            
            label.textColor =  UIColor { tc in
                     switch tc.userInterfaceStyle {
                     case .dark:
                         return UIColor.white
                     default:
                         return UIColor.black
                     }
                }
            
        }

        if text == "Next" {
            //label.font = UIFont(name: "Arizonia", size: fontsize)
            label.textColor = .systemGray4
        }
        label.adjustsFontSizeToFitWidth = true
        view1.addSubview(label)
        
    }
    
    func newimage (view1: UIView, name: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        
        let locView = UIImageView(frame: CGRect(x: view1.frame.width * x, y: view1.frame.height * y, width: view1.frame.width * width, height: view1.frame.height * height))
        
        locView.contentMode = UIView.ContentMode.scaleAspectFit
        
        if let url = URL(string:name){
          locView.load(url: url)
        }
        
        view1.addSubview(locView)
        
    }
    
    func realpronos () {
        
        var gebruikers: [String] = []
        var homeTeams: [String] = []
        var awayTeams: [String] = []
        
        guard let filepath = Bundle.main.path(forResource: "WK 2022 xcode", ofType: "xlsx") else {

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
                
                let fixture =  Fixtures(index: 0, venue: "", time: "-", team_1: homeTeams[1 + ga * i], goals_1: Int((worksheet.data?.rows[1 + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[1 + ga * i], goals_2: Int((worksheet.data?.rows[1 + ga * i].cells[5].value)!)!, logo_2: "", user: gebruikers[1 + ga * i])
                
                PronosB[i].append(fixture)
                
                for n in 1...ga - 1 {
                    
                    // Loop games
                    
                    let fixture =  Fixtures(index: n, venue: "", time: "-", team_1: homeTeams[(n + 1) + ga * i], goals_1: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[(n + 1) + ga * i], goals_2: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[5].value)!)!, logo_2: "", user: gebruikers[(n + 1) + ga * i])
                    
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
        
        guard let filepath = Bundle.main.path(forResource: "WK 2022 xcode", ofType: "xlsx") else {

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
                
                let fixture =  Fixtures(index: 0, venue: "", time: "-", team_1: homeTeams[1 + ga * i], goals_1: Int((worksheet.data?.rows[1 + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[1 + ga * i], goals_2: Int((worksheet.data?.rows[1 + ga * i].cells[5].value)!)!, logo_2: "", user: "Tournament")
                
                FixturesA.append(fixture)
                
                for n in 1...ga - 1 {
                    
                    // Loop games
                    
                    let fixture =  Fixtures(index: n, venue: "", time: "-", team_1: homeTeams[(n + 1) + ga * i], goals_1: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[4].value)!)!, logo_1: "", team_2: awayTeams[(n + 1) + ga * i], goals_2: Int((worksheet.data?.rows[(n + 1) + ga * i].cells[5].value)!)!, logo_2: "", user: "Tournament")
                    
                    FixturesA.append(fixture)
                    
                }
                
            }
            
          }
        }
    }
    
    func removeSV (viewsv: UIView) {
     
        viewsv.subviews.forEach { (item) in
        item.removeFromSuperview()
        }
        
    }
    
}
