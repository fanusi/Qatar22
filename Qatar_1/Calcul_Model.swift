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
    var lastgame1: Int = 0

    
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
        
        let homegoals_real: Int = Int(fixtures[game].goals_1)
        let awaygoals_real: Int = Int(fixtures[game].goals_2)
        let hometeam_real: String = fixtures[game].team_1
        let awayteam_real: String = fixtures[game].team_2
        
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
        
            let homegoals_real: Int = Int(fixtures[game].goals_1)
            let awaygoals_real: Int = Int(fixtures[game].goals_2)
            let hometeam_real: String = fixtures[game].team_1
            let awayteam_real: String = fixtures[game].team_2
            
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
            
            //print("Test----")
            //print(kwalnextround.count)
            
            // Give points for qualifying next round
            for i in 0...end-start {
                
                //print(kwalnextround[i])
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
        
        // Last third group games for all groups
        let aa: Int = 33
        let bb: Int = 35
        let cc: Int = 37
        let dd: Int = 39
        let ee: Int = 41
        let ff: Int = 43
        let gg: Int = 45
        let hh: Int = 47
        

//        let aa: Int = 25
//        let bb: Int = 29
//        let cc: Int = 27
//        let dd: Int = 31
//        let ee: Int = 33
//        let ff: Int = 35
            
        let lastgames: [Int] = [aa, bb, cc, dd, ee, ff, gg, hh]
        // let lastgames: [Int] = [aa, bb, cc, dd, ee, ff]
            
        var punten: Int = 0
        
        let homegoals_real: Int = Int(fixtures[game].goals_1)
        let awaygoals_real: Int = Int(fixtures[game].goals_2)
        let hometeam_real: String = fixtures[game].team_1
        let awayteam_real: String = fixtures[game].team_2
        
        let homegoals_prono: Int = Int(speler[game].goals_1)
        let awaygoals_prono: Int = Int(speler[game].goals_2)
        let hometeam_prono: String = speler[game].team_1
        let awayteam_prono: String = speler[game].team_2
        
        
        if lastgames.contains(game) && fixtures[game].status != "NS" {
        // Last group game, then check for qualifiers
            
            let group: [String] = [fixtures[game].team_1, fixtures[game].team_2, fixtures[game-1].team_1, fixtures[game-1].team_2]
            
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
        
        for i in 0...standings.count-1 {
            
            if standings[i].rank == 1 || standings[i].rank == 2 {
                
                let qteam: String = standings[i].team
                qbest.append(qteam)
                    
            }
            
        }
        
        return qbest
        
    }
    
    func routine () {
               
        standen.removeAll()
        
        for i in 0...pr-1 {
            
            calculator(speler: PronosB[i])
            
            let newscore = Scores(user: (pronos[i].first?.user)!, punten: puntenSommatie(z: ga-1, speler: PronosB[i]), index: i)

            standen.append(newscore)
            
        }
        
        standen = standen.sorted(by: { ($0.punten) > ($1.punten) })
        //PronosB = PronosB.sorted(by: { ($0.last?.statistiek!.punten)! > ($1.last?.statistiek!.punten)! })
        
        for i in 0...pr-1 {
            
            standen[i].ranking = i
            //print(standen[i].ranking)
            //print(standen[i].index)
            
        }
        
        
    }
    
    func calculator (speler: [Fixtures]) {
        
        let teller3:Int = 32
        // Index start of third group game

        let tellerA:Int = 48
        // Index start of round best of 16

        let tellerQ:Int = 56
        // Index start of round quarter finals

        let tellerS:Int = 60
        // Index start of round semi finals

        let tellerF:Int = 62
        // Index start of round final
        
        
//        let teller3:Int = 24
//        // Index start of third group game
//
//        let tellerA:Int = 36
//        // Index start of round best of 16
//
//        let tellerQ:Int = 44
//        // Index start of round quarter finals
//
//        let tellerS:Int = 48
//        // Index start of round semi finals
//
//        let tellerF:Int = 50
//        // Index start of round final
        
        
        for j in 0...ga-1 {
            
            //reset punten voor elke match
            var punten:Int = 0
            
            let homegoals_real: Int = Int(fixtures[j].goals_1)
            let awaygoals_real: Int = Int(fixtures[j].goals_2)
            let homegoals_prono: Int = Int(speler[j].goals_1)
            let awaygoals_prono: Int = Int(speler[j].goals_2)
    
            if j < teller3 {
                
                //First 2 group matches
                punten = punten + calc_simple(hg_p: homegoals_prono, ag_p: awaygoals_prono, hg_r: homegoals_real, ag_r: awaygoals_real)
                
                //                if speler[0].user == "Player 2" {
                //
                //                    print(PronosA[j].home_Team! + " - " + PronosA[j].away_Team!)
                //                    print(String(homegoals_real) + "-" + String(awaygoals_real))
                //
                //                    print(speler[j].home_Team! + " - " + speler[j].away_Team!)
                //                    print(String(homegoals_prono) + "-" + String(awaygoals_prono))
                //
                //                    print(" punten " + String(punten))
                //
                //                    print("//")
                //
                //                }
                
                // UNCOMMENT FOLLOWING CODE FOR REAL TOURNAMENT !!!!!!!! (Comment next line bracket)
                
            
            } else if j < tellerA {

                //Third group game
                punten = punten + calc_ext3(round: 3,game: j, speler: speler, start: tellerA, end: tellerQ-1)

            } else if j < tellerQ {

                //Best of 16
                punten = punten + calc_ext2(round: 4,game: j, speler: speler, start: tellerA, end: tellerQ-1)

            } else if j < tellerS {

                //Quarter finals
                punten = punten + calc_ext2(round: 5,game: j, speler: speler, start: tellerQ, end: tellerS-1)

            } else if j < tellerF {

                //semi finals
                punten = punten + calc_ext2(round: 6,game: j, speler: speler, start: tellerS, end: tellerF-1)
            
//            } else if j == ga-1 {
//
//                //Final
//                punten = punten + calc_ext2(round: 10,game: j, speler: speler, start: tellerF, end: ga-1)
//
//            }

            } else if j == ga-2 {

                //Final third place
                punten = punten + calc_ext2(round: 8,game: j, speler: speler, start: tellerF, end: ga-2)

            } else if j == ga-1 {

                //Final
                punten = punten + calc_ext2(round: 10,game: j, speler: speler, start: ga-1, end: ga-1)

            }
            
            //toewijzen van punten
            speler[j].punten = punten
            
        }
        
    }
    
    func puntenSommatie (z: Int, speler: [Fixtures]) -> Int {
        
        var som:Int = 0
        
        for l in 0...z {
            
            som = som + Int(speler[l].punten)
            
        }
        
        return som
        
    }
    
    func lastgame() -> Int {
        
        var fg:Int = 0
        
        for n in 0...fixtures.count-1 {
            
            var dummy:Int = 0
            
            if fixtures[n].status == "FT" || fixtures[n].status == "AET" || fixtures[n].status == "PEN"  {
                
                if dummy == 0 {
                    
                    fg = fg + 1
                    
                }
                
            } else if fixtures[n].status == "1H" || fixtures[n].status == "2H" || fixtures[n].status == "HT" || fixtures[n].status == "ET" || fixtures[n].status == "P" || fixtures[n].status == "BT" {
                fg = n
                dummy = 1
            }
            
        }
        
        
        return min(fg, ga - 1) - 1
        
    }
    
    func transferString(Astrings: [String]) -> String {
        
        var Svalue:String = ""
        
        if Astrings[0] != "" {
            
            Svalue = "Q1"
            
            if Astrings[3] != "" {
             
                Svalue = "X2"
            
            }
                
        } else if Astrings[3] != "" {
            
            Svalue = "Q2"
            
            if Astrings[0] != "" {
             
                Svalue = "X2"
            
            }
                
        }
        
        return Svalue
        
    }
    
    func extra(livegames: Int) {
        
        let ind: [Int] = [sr - fr, qf - fr, sf - fr, f - fr, ga]
        //Index second round, quarter finals, semi finals, finals and last game
        
        for a in 0...standen.count - 1 {
            
            standen[a].extra = ""
            standen[a].extra_meta = ""
            standen[a].extra2 = ""
            standen[a].extra_meta2 = ""
            let i = standen[a].index
            
            if livegames == 1 {
                
                if LiveGamesA[0].index < ind[0] {
                // 1st round games
                
                    let temp1: String = String(PronosB[i][LiveGamesA[0].index].goals_1)
                    let temp2: String = String(PronosB[i][LiveGamesA[0].index].goals_2)
                    let temp3: String = temp1 + "-" + temp2
                    
                    standen[a].extra = temp3
                    
                    let temp4: String = String(fixtures[LiveGamesA[0].index].goals_1)
                    let temp5: String = String(fixtures[LiveGamesA[0].index].goals_2)
                    let temp6: String = temp4 + "-" + temp5
                    
                    let burn1:Bool = burn(hgp: Int(temp1)!, agp: Int(temp2)!, hgr: Int(temp4)!, agr: Int(temp5)!)
                    
                    if temp3 == temp6 {
                        standen[a].extra_meta = "Perfect Guess"
                    } else if burn1 {
                        standen[a].extra_meta = "Burn"
                    }
                    
                    
                } else {
                // 2nd round
                    
                    let VC2 = ViewController2()
                    let QualText:[String] = VC2.secondround(game: LiveGamesA[0].index, user: i, rteam1: fixtures[LiveGamesA[0].index].team_1, rteam2: fixtures[LiveGamesA[0].index].team_2)
    
                    if QualText[0] == LiveGamesA[0].team_1 {
                    // Perfect guess
                        
                        let temp3 = QualText[1] + "-" + QualText[2]
                        standen[a].extra = temp3
                        
                        let temp4: String = String(fixtures[LiveGamesA[0].index].goals_1)
                        let temp5: String = String(fixtures[LiveGamesA[0].index].goals_2)
                        let temp6: String = temp4 + "-" + temp5
                        
                        if temp3 == temp6 {
                            standen[a].extra_meta = "Perfect Guess"
                        } else {
                            standen[a].extra_meta = "Perfect Prediction"
                        }
                        
                    } else {
                        
                        standen[a].extra = transferString(Astrings: QualText)
                        
                        if standen[a].extra == "X2" {
                            
                            standen[a].extra_meta = "Both Qualified"
                            
                        }
                        
                    }

                    
                }
            
                
            } else if LiveGamesA.count == 2 {
                
                if LiveGamesA[0].index < ind[0] {
                // 1st round games
                
                    let temp1: String = String(PronosB[i][LiveGamesA[0].index].goals_1)
                    let temp2: String = String(PronosB[i][LiveGamesA[0].index].goals_2)
                    let temp3: String = temp1 + "-" + temp2
                    standen[a].extra = temp3
                    
                    let temp7: String = String(PronosB[i][LiveGamesA[1].index].goals_1)
                    let temp8: String = String(PronosB[i][LiveGamesA[1].index].goals_2)
                    let temp9: String = temp7 + "-" + temp8
                    standen[a].extra2 = temp9
                    
                    let temp4: String = String(fixtures[LiveGamesA[0].index].goals_1)
                    let temp5: String = String(fixtures[LiveGamesA[0].index].goals_2)
                    let temp6: String = temp4 + "-" + temp5
                    
                    let temp10: String = String(fixtures[LiveGamesA[1].index].goals_1)
                    let temp11: String = String(fixtures[LiveGamesA[1].index].goals_2)
                    let temp12: String = temp10 + "-" + temp11
                    
                    let burn1:Bool = burn(hgp: Int(temp1)!, agp: Int(temp2)!, hgr: Int(temp4)!, agr: Int(temp5)!)
                    
                    let burn2:Bool = burn(hgp: Int(temp7)!, agp: Int(temp8)!, hgr: Int(temp10)!, agr: Int(temp11)!)
                    
                    if temp3 == temp6 {
                        standen[a].extra_meta = "Perfect Guess"
                    } else if burn1 {
                        standen[a].extra_meta = "Burn"
                    }
                    
                    if temp9 == temp12 {
                        standen[a].extra_meta2 = "Perfect Guess"
                    } else if burn2 {
                        standen[a].extra_meta2 = "Burn"
                    }
                    
                } else {
                // 2nd round
                    
                    let VC2 = ViewController2()
                    let QualText:[String] = VC2.secondround(game: LiveGamesA[0].index, user: i, rteam1: fixtures[LiveGamesA[0].index].team_1, rteam2: fixtures[LiveGamesA[0].index].team_2)
                    
                    let QualText2:[String] = VC2.secondround(game: LiveGamesA[1].index, user: i, rteam1: fixtures[LiveGamesA[1].index].team_1, rteam2: fixtures[LiveGamesA[1].index].team_2)
    
                    if QualText[0] == LiveGamesA[0].team_1 {
                    // Perfect guess
                        
                        let temp3 = QualText[1] + "-" + QualText[2]
                        standen[a].extra = temp3
                        
                        let temp4: String = String(fixtures[LiveGamesA[0].index].goals_1)
                        let temp5: String = String(fixtures[LiveGamesA[0].index].goals_2)
                        let temp6: String = temp4 + "-" + temp5
                        
                        if temp3 == temp6 {
                            standen[a].extra_meta = "Perfect Guess"
                        } else {
                            standen[a].extra_meta = "Perfect Prediction"
                        }
                        
                    } else {
                        
                        standen[a].extra = transferString(Astrings: QualText)
                        
                        if standen[a].extra == "X2" {
                            
                            standen[a].extra_meta = "Both Qualified"
                            
                        }
                        
                    }

                    if QualText2[0] == LiveGamesA[1].team_1 {
                    // Perfect guess
                        
                        let temp9 = QualText2[1] + "-" + QualText2[2]
                        standen[a].extra2 = temp9
                        
                        let temp10: String = String(fixtures[LiveGamesA[1].index].goals_1)
                        let temp11: String = String(fixtures[LiveGamesA[1].index].goals_2)
                        let temp12: String = temp10 + "-" + temp11
                        
                        if temp9 == temp12 {
                            standen[a].extra_meta2 = "Perfect Guess"
                        } else {
                            standen[a].extra_meta2 = "Perfect Prediction"
                        }
                        
                    } else {
                        
                        standen[a].extra2 = transferString(Astrings: QualText2)
                        
                        if standen[a].extra2 == "X2" {
                            
                            standen[a].extra_meta2 = "Both Qualified"
                            
                        }
                        
                    }
                    
                }
                
            } else {
            // No live games, return points last game
                
                if lastgame1 == -1 {
                    standen[a].extra = " "
                } else {
                    standen[a].extra = laatstepunten(speler: PronosB[i], game: lastgame1)
                }
                
            }
            
        }
        
    }
    
    func laatstepunten (speler: [Fixtures], game: Int) -> String {
        
        var str: String
        let a: Int = speler[game].punten
        var b: Int = 0
        
        let aa: Int = 33
        let bb: Int = 35
        let cc: Int = 37
        let dd: Int = 39
        let ee: Int = 41
        let ff: Int = 43
        let gg: Int = 45
        let hh: Int = 47
        
        let lastgames: [Int] = [aa, bb, cc, dd, ee, ff, gg, hh]
        
        if lastgames.contains(game) {
            b = speler[game-1].punten
        }
        
        str = String(a + b)
        
        if str == "0" {
            
            str = ""
            
        } else {
            
            str = "+ " + str
        }
        
        return str
        
    }
    
    func average () {
        
        if calcul.fixtures.count > 0 {
            
            for i in 0...calcul.fixtures.count - 1 {
                
                var av: Double = 0
                
                if calcul.pronos.count > 0 {
                    
                    for j in 0...calcul.pronos.count - 1 {
                        
                        av = av + Double(calcul.pronos[j][i].punten)
                        
                    }
                    
                    av = av / Double(calcul.pronos.count)
                    
                    av = Double(round(10 * av) / 10)
                    
                }
                
                calcul.fixtures[i].average = String(av)
                
            }
            
        }
        
    }
    
    
}
