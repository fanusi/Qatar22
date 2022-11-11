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
                
            }

        } else {

            cell.rankLabel.text = ""
            cell.playerLabel.text = ""
            cell.recentLabel.text = ""
            cell.recent3Label.text = ""
            cell.recent5Label.text = ""
            cell.recent7Label.text = ""
            cell.pointsLabel.text = ""
            
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
                
                print(prono)
                
                let temp = 50
                
                print("Game nr")
                print(calcul.lastgame1-temp)
                
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
    
}
