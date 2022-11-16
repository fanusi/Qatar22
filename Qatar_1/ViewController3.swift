//
//  ViewController3.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import UIKit

final class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcul.standen.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"DetailStandViewCell", for: indexPath) as! DetailCell
        
        if indexPath.row <= calcul.standen.count {
        
            if indexPath.row == 0 {
                
                let sfont:CGFloat = 15
                let nfont: String = "Arial-BoldMT"
                
                cell.rankLabel.text = "R"
                cell.playerLabel.text = "Player"
                cell.recentLabel.text = "Last"
                cell.recent3Label.text = "L3"
                cell.recent5Label.text = "L5"
                cell.recent7Label.text = "L7"
                cell.pointsLabel.text = "Points"
                
                cell.rankLabel.font = UIFont(name: nfont, size: sfont)
                cell.playerLabel.font = UIFont(name: nfont, size: sfont)
                cell.recentLabel.font = UIFont(name: nfont, size: sfont)
                cell.recent3Label.font = UIFont(name: nfont, size: sfont)
                cell.recent5Label.font = UIFont(name: nfont, size: sfont)
                cell.recent7Label.font = UIFont(name: nfont, size: sfont)
                cell.pointsLabel.font = UIFont(name: nfont, size: sfont)
                
                cell.rankLabel.backgroundColor = label_color(points: 0, average: 0)
                cell.playerLabel.backgroundColor = label_color(points: 0, average: 0)
                cell.recentLabel.backgroundColor = label_color(points: 0, average: 0)
                cell.recent3Label.backgroundColor = label_color(points: 0, average: 0)
                cell.recent5Label.backgroundColor = label_color(points: 0, average: 0)
                cell.recent7Label.backgroundColor = label_color(points: 0, average: 0)
                cell.pointsLabel.backgroundColor = label_color(points: 0, average: 0)
                
            } else {
                
                let sfont:CGFloat = 15
                let nfont: String = "ArialMT"
                
                let ind = calcul.standen[indexPath.row-1].index
                
                cell.rankLabel.text = String(calcul.standen[indexPath.row-1].ranking + 1)
                cell.playerLabel.text = String(calcul.standen[indexPath.row-1].user)
                cell.recentLabel.text = String(avlast(prono: ind)[0])
                cell.recent3Label.text = String(avlast(prono: ind)[1])
                cell.recent5Label.text = String(avlast(prono: ind)[2])
                cell.recent7Label.text = String(avlast(prono: ind)[3])
                cell.pointsLabel.text = String(calcul.standen[indexPath.row-1].punten)
                
                cell.rankLabel.font = UIFont(name: nfont, size: sfont)
                cell.playerLabel.font = UIFont(name: nfont, size: sfont)
                cell.recentLabel.font = UIFont(name: nfont, size: sfont)
                cell.recent3Label.font = UIFont(name: nfont, size: sfont)
                cell.recent5Label.font = UIFont(name: nfont, size: sfont)
                cell.recent7Label.font = UIFont(name: nfont, size: sfont)
                cell.pointsLabel.font = UIFont(name: nfont, size: sfont)
                
                cell.rankLabel.backgroundColor = label_color(points: 0, average: 0)
                cell.playerLabel.backgroundColor = label_color(points: 0, average: 0)
                cell.recentLabel.backgroundColor = label_color(points: avlast(prono: ind)[0], average: avlast_all(prono: ind)[0])
                cell.recent3Label.backgroundColor = label_color(points: avlast(prono: ind)[1], average: avlast_all(prono: ind)[1])
                cell.recent5Label.backgroundColor = label_color(points: avlast(prono: ind)[2], average: avlast_all(prono: ind)[2])
                cell.recent7Label.backgroundColor = label_color(points: avlast(prono: ind)[3], average: avlast_all(prono: ind)[3])
                cell.pointsLabel.backgroundColor = label_color(points: 0, average: 0)
                
                print("avlast")
                //print(avlast(prono: ind)[0])
                print(avlast_all(prono: ind)[0])

                print("avlast3")
                //print(avlast(prono: ind)[1])
                print(avlast_all(prono: ind)[1])

                
            }

        } else {

            cell.rankLabel.text = ""
            cell.playerLabel.text = ""
            cell.recentLabel.text = ""
            cell.recent3Label.text = ""
            cell.recent5Label.text = ""
            cell.recent7Label.text = ""
            cell.pointsLabel.text = ""
            
            cell.rankLabel.backgroundColor = label_color(points: 0, average: 0)
            cell.playerLabel.backgroundColor = label_color(points: 0, average: 0)
            cell.recentLabel.backgroundColor = label_color(points: 0, average: 0)
            cell.recent3Label.backgroundColor = label_color(points: 0, average: 0)
            cell.recent5Label.backgroundColor = label_color(points: 0, average: 0)
            cell.recent7Label.backgroundColor = label_color(points: 0, average: 0)
            cell.pointsLabel.backgroundColor = label_color(points: 0, average: 0)
            
        }
                        
        cell.rankLabel.textAlignment = .center
        cell.recentLabel.textAlignment = .center
        cell.recent3Label.textAlignment = .center
        cell.recent5Label.textAlignment = .center
        cell.recent7Label.textAlignment = .center
        cell.pointsLabel.textAlignment = .center

        cell.rankLabel.adjustsFontSizeToFitWidth = true
        cell.playerLabel.adjustsFontSizeToFitWidth = true
        cell.recentLabel.adjustsFontSizeToFitWidth = true
        cell.recent3Label.adjustsFontSizeToFitWidth = true
        cell.recent5Label.adjustsFontSizeToFitWidth = true
        cell.recent7Label.adjustsFontSizeToFitWidth = true
        cell.pointsLabel.adjustsFontSizeToFitWidth = true
        
        // Visuals
        cell.DetailView.layer.cornerRadius = cell.DetailView.frame.height / 8
        
        return cell
    }
    
    
    static let identifer = "ViewController3"

    var number: Int = 0
    static let idc: Int = 3

    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        tableView1.dataSource = self
        tableView1.delegate = self
        //tableView1.refreshControl = UIRefreshControl()
        //tableView1.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        // Visuals TableView
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        
    }
    
    func avlast (prono: Int) -> [Int] {
    // Returns [last, last 3, last 5, last 7]
        
        var last: Int = 0
        var last3: Int = 0
        var last5: Int = 0
        var last7: Int = 0
        
        if calcul.fixtures.count > 0 && calcul.pronos.count > 0 && calcul.standen.count > 0 && calcul.standings.count > 0 {
                                    
            if calcul.lastgame1 != -1 {
                
                //var temp: Int = 0
                //var temp3: Int = 0
                
                //let n = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1)[1]
                //Number of (past) games for average
                
                //print(prono)
                
                let temp = 0
                
                //print("Game nr")
                //print(calcul.lastgame1-temp)
                
                last = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1-temp)[0]
                
                last3 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1-temp, past: 3)[0]
                
                last5 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1-temp, past: 5)[0]
                                
                last7 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1-temp, past: 7)[0]
                                
//                for i in 0...calcul.standen.count-1 {
//
//                    temp += calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1-50)[0]
//                    temp3 += calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1-50, past: 3)[0]
//
//                }
                
                //last = Double(temp / n)
                //last5 = Double(temp3 / n)
                
                //last = Double(round(10 * last) / 10)
                //last3 = Double(round(10 * last3) / 10)
                //last5 = Double(round(10 * last5) / 10)
                //last7 = Double(round(10 * last7) / 10)
                
            }
            
        }
        
        return [last, last3, last5, last7]
        
    }
    
    func avlast_all (prono: Int) -> [Double] {
    // Returns [last, last 3, last 5, last 7] players average
        
        var last: Double = 0
        var last3: Double = 0
        var last5: Double = 0
        var last7: Double = 0
        
        if calcul.fixtures.count > 0 && calcul.pronos.count > 0 && calcul.standen.count > 0 && calcul.standings.count > 0 {
                                    
            if calcul.lastgame1 != -1 {
                
                var temp: Double = 0
                var temp3: Double = 0
                var temp5: Double = 0
                var temp7: Double = 0
                
//                let n = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1)[1]
//                let n3 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1, past: 3)[1]
//                let n5 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1, past: 5)[1]
//                let n7 = calcul.laatstepunten_2(speler: calcul.pronos[prono], game: calcul.lastgame1, past: 7)[1]
                
                //print("_")
                //print(n)
                //print(n3)
                //print(n5)
                //print(n7)
                //print("_")
                
                //Number of (past) games for average
                
                //print(prono)
                //print("Game nr")
                //print(calcul.lastgame1)
                                
                for i in 0...calcul.standen.count-1 {

                    temp += Double(calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1)[0])
                    temp3 += Double(calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1, past: 3)[0])
                    temp5 += Double(calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1, past: 5)[0])
                    temp7 += Double(calcul.laatstepunten_2(speler: calcul.pronos[i], game: calcul.lastgame1, past: 7)[0])

                }
                
                last = temp / Double(calcul.standen.count)
                last3 = temp3 / Double(calcul.standen.count)
                last5 = temp5 / Double(calcul.standen.count)
                last7 = temp7 / Double(calcul.standen.count)
                
//                last = Double(round(100 * last) / 100)
//                last3 = Double(round(100 * last3) / 100)
//                last5 = Double(round(100 * last5) / 100)
//                last7 = Double(round(100 * last7) / 100)
                
            }
            
        }
        
        return [last, last3, last5, last7]
        
    }
    
    func label_color(points: Int, average: Double) -> UIColor {
        
        var labelColor: UIColor = .white
        
        let u1: Double = 1.3 * average
        let u2: Double = 2.0 * average
        let d1: Double = 0.7 * average
        let d2: Double = 0.5 * average
        
        if labelColor == .white {
            
            labelColor =  UIColor { tc in
                     switch tc.userInterfaceStyle {
                     case .dark:
                         return UIColor.black
                     default:
                         return UIColor.white
                     }
                }
        }
        
        if Double(points) > u1 && Double(points) < u2  {
            
            labelColor = UIColor(red: 0.6824, green: 0.9882, blue: 0.702, alpha: 1.0)
            
        } else if Double(points) > (u2 * 0.99) {
            
            labelColor =
            UIColor(red: 0, green: 0.9882, blue: 0.0627, alpha: 1.0)
            
        } else if Double(points) < d1 && Double(points) > d2  {
            
            labelColor = UIColor(red: 0.9765, green: 0.7922, blue: 0.4667, alpha: 1.0)
        
        } else if Double(points) < (d2 * 1.01) {
            
            labelColor = UIColor(red: 1, green: 0.5098, blue: 0.5098, alpha: 1.0)
            
        }
            
        return labelColor
        
    }
    
}


