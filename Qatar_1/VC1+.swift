//
//  VC1+.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 16/09/2022.
//

import Foundation

extension ViewController1 {
    
    func fixtureParsing () {
        
            FixturesA.removeAll()
        
            let headers = [
                "X-RapidAPI-Key": "71b7ad779emsh4620b05b06325aep1504b4jsn595d087d75ec",
                "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
            ]

            //World Cup = 1; Jupiler Pro League = 144
            let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=144&season=2022&next=20")! as URL,
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

    
}
