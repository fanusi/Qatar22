//
//  Calcul_Model.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 24/09/2022.
//

import Foundation

public class CalculModel {
    
    var fixtures: [Fixtures]
    var pronos: [[Fixtures]]
    var standen: [Scores]
    var standings: [Standings]

    
    init(fixtures: [Fixtures], pronos: [[Fixtures]], standen: [Scores], standings: [Standings]) {
        
        self.fixtures = fixtures
        self.pronos = pronos
        self.standen = standen
        self.standings = standings
        
    }
    
    func burn(hgp: Int, agp: Int, hgr: Int, agr: Int) -> Bool {
        
        var dummy:Bool = false
        
        if hgr > agr {
            
            if hgp < agp || hgp == agp {
                
                dummy = true
                
            }
            
        } else if hgr < agr {
            
            if hgp > agp || hgp == agp {
                
                dummy = true
                
            }
            
        } else if hgr == agr {
            
            if hgp > agp || hgp < agp {
                
                dummy = true
                
            }
            
        }
        
        return dummy
        
    }
    
    func calc_simple (hg_p: Int, ag_p: Int, hg_r: Int, ag_r: Int) -> Int {
            
            var punten: Int = 0
            
            if hg_r >= 0 {
            
                if hg_r > ag_r && hg_p > ag_p {
                    
                    punten = punten + 1
                    
                    if hg_r == hg_p {
                        
                        punten = punten + 1
                        
                    }
                    
                    if ag_r == ag_p {
                        
                        punten = punten + 1
                        
                    }
                    
                }

                if hg_r < ag_r && hg_p < ag_p {
                    
                    punten = punten + 1
                    
                    if hg_r == hg_p {
                        
                        punten = punten + 1
                        
                    }
                    
                    if ag_r == ag_p {
                        
                        punten = punten + 1
                        
                    }
                         
                }

                if hg_r == ag_r && hg_p == ag_p {
                    
                    punten = punten + 1
                    
                    if hg_r == hg_p {
                        
                        punten = punten + 2
                        
                    }
                         
                }
            
            }
            
            return punten
            
            
        }
    
    func calc_ext (round: Int, game: Int, speler: [Fixtures], start: Int, end: Int ) -> Int {
        
        var punten: Int = 0
        var dcheck: Int = 0
        
        let homegoals_real: Int = Int(FixturesA[game].goals_1)
        let awaygoals_real: Int = Int(FixturesA[game].goals_2)
        let hometeam_real: String = FixturesA[game].team_1
        let awayteam_real: String = FixturesA[game].team_2
        
        var homegoals_prono: Int = 0
        var awaygoals_prono: Int = 0
        var hometeam_prono: String = ""
        var awayteam_prono: String = ""
        
        //Points for guessing right teams in round
        for i in start...end {
        
            dcheck = 0
            
            if hometeam_real == speler[i].team_1 {
                
                punten = punten + round
                homegoals_prono = Int(speler[i].goals_1)
                hometeam_prono = speler[i].team_1
                dcheck = 1
                
            } else if hometeam_real == speler[i].team_2 {
                
                punten = punten + round
                homegoals_prono = Int(speler[i].goals_2)
                hometeam_prono = speler[i].team_2
                dcheck = 1
            
            }
            
            if awayteam_real == speler[i].team_2 {
                
                punten = punten + round
                awaygoals_prono = Int(speler[i].goals_2)
                awayteam_prono = speler[i].team_2
                dcheck = dcheck + 1
                
            } else if awayteam_real == speler[i].team_1 {
                
                punten = punten + round
                awaygoals_prono = Int(speler[i].goals_1)
                awayteam_prono = speler[i].team_1
                dcheck = dcheck + 1
            
            }
            
            if dcheck == 2 {
                
                punten = punten + calc_simple(hg_p: homegoals_prono, ag_p: awaygoals_prono, hg_r: homegoals_real, ag_r: awaygoals_real)
                
            }
            
            if round == 6 {
                
                if homegoals_real > awaygoals_real && homegoals_prono > awaygoals_prono {
                    
                    punten = punten + 10
                    
                } else if homegoals_real < awaygoals_real && homegoals_prono < awaygoals_prono {
                    
                    punten = punten + 10
                    
                }
                
            }
            
        }
        
                
        return punten
                
                
    }
    
    func calc_ext2 (round: Int, game: Int, speler: [Fixtures], start: Int, end: Int) -> Int {
                
            
            var punten: Int = 0
            var dcheck: Int = 0
        
            let homegoals_real: Int = Int(FixturesA[game].goals_1)
            let awaygoals_real: Int = Int(FixturesA[game].goals_2)
            let hometeam_real: String = FixturesA[game].team_1
            let awayteam_real: String = FixturesA[game].team_2
            
            var homegoals_prono: Int = 0
            var awaygoals_prono: Int = 0
            var hometeam_prono: String = ""
            var awayteam_prono: String = ""
            
            let kwalnextround: [String] = kwalificatieR(speler: speler, start: start, end: end)
            //Populate matrix with qualifying teams in prediction next round
            
            var qualProno: String = ""
            //Qualifying team in tournament
            
            if homegoals_real > awaygoals_real {
                
                qualProno = hometeam_real
                
            } else if homegoals_real < awaygoals_real {
                
                qualProno = awayteam_real
                
            }
            
            //Check if game has been exactly predicted
            for i in start...end {
            
                dcheck = 0
                
                if hometeam_real == speler[i].team_1 {
                    
                    homegoals_prono = Int(speler[i].goals_1)
                    hometeam_prono = speler[i].team_1
                    dcheck = 1
                    
                } else if hometeam_real == speler[i].team_2 {
                    
                    homegoals_prono = Int(speler[i].goals_2)
                    hometeam_prono = speler[i].team_2
                    dcheck = 1
                
                }
                
                if awayteam_real == speler[i].team_2 {
                    
                    awaygoals_prono = Int(speler[i].goals_2)
                    awayteam_prono = speler[i].team_2
                    dcheck = dcheck + 1
                    
                } else if awayteam_real == speler[i].team_1 {
                    
                    awaygoals_prono = Int(speler[i].goals_1)
                    awayteam_prono = speler[i].team_1
                    dcheck = dcheck + 1
                
                }
                
                if dcheck == 2 {
                    
                    punten = punten + calc_simple(hg_p: homegoals_prono, ag_p: awaygoals_prono, hg_r: homegoals_real, ag_r: awaygoals_real)
                    
                }
                
            }
            
            print("Test----")
            print(kwalnextround.count)
            
            // Give points for qualifying next round
            for i in 0...end-start {
                
                print(kwalnextround[i])
                if qualProno == kwalnextround[i] {
                    punten = punten + round
                }
                
            }
            
            return punten
            
        }
    
    func kwalificatieR (speler: [Fixtures], start: Int, end: Int) -> [String] {
    
        //Create a string matrix with all qualifiers from prediction
        
        var qualifiers = [String]()
        
        for i in start...end {
        
            if speler[i].goals_1 > speler[i].goals_2 {
                
                let kf: String = speler[i].team_1
                qualifiers.append(kf)
                
            } else if speler[i].goals_1 < speler[i].goals_2 {
                
                let kf: String = speler[i].team_2
                qualifiers.append(kf)
            
            } else {

                let kf: String = "Unknown"
                qualifiers.append(kf)
                
            }
            
        }
        
        return qualifiers
        
    }
    
    func calc_ext3 (round: Int, game: Int, speler: [Fixtures], start: Int, end: Int) -> Int {
        
            // Third Group
            // Last third group games for all groups
            let aa: Int = 33
            let bb: Int = 35
            let cc: Int = 37
            let dd: Int = 39
            let ee: Int = 41
            let ff: Int = 43
            let gg: Int = 45
            let hh: Int = 47
            
            let lastgames: [Int] = [aa, bb, cc, dd, ee, ff, gg, hh]
            
            var punten: Int = 0
            
            let homegoals_real: Int = Int(FixturesA[game].goals_1)
            let awaygoals_real: Int = Int(FixturesA[game].goals_2)
            let hometeam_real: String = FixturesA[game].team_1
            let awayteam_real: String = FixturesA[game].team_2
            
            let homegoals_prono: Int = Int(speler[game].goals_1)
            let awaygoals_prono: Int = Int(speler[game].goals_2)
            let hometeam_prono: String = speler[game].team_1
            let awayteam_prono: String = speler[game].team_2
            
            
            if lastgames.contains(game) && FixturesA[game].status != "NS" {
            // Last group game, then check for qualifiers
                
                let group: [String] = [FixturesA[game].team_1, FixturesA[game].team_2, FixturesA[game-1].team_1, FixturesA[game-1].team_2]
                
                for i in start...end {
                    
                    if qual16.contains(speler[i].team_1) && group.contains(speler[i].team_1) {
                        
                        punten = punten + round
                        
                    }

                    if qual16.contains(speler[i].team_2) && group.contains(speler[i].team_2) {
                        
                        punten = punten + round
                        
                    }
                    
                }
                
            }

            
            punten = punten + calc_simple(hg_p: homegoals_prono, ag_p: awaygoals_prono, hg_r: homegoals_real, ag_r: awaygoals_real)
                    
            return punten
            
        }
    
    func qualbest2 () -> [String] {
    // Populates best two teams from each group
        
        var qbest: [String] = []
        
        for i in 0...StandingsA.count-1 {
            
            if StandingsA[i].rank == 1 || StandingsA[i].rank == 2 {
                
                let qteam: String = StandingsA[i].team
                qbest.append(qteam)
                    
            }
            
        }
        
        return qbest
        
        
    }
    
    
}
