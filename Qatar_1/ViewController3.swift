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
                cell.averageLabel.text = "Aver"
                cell.recent3Label.text = "L3"
                cell.average3Label.text = "A3"
                cell.pointsLabel.text = "Points"
                
                cell.rankLabel.font = UIFont(name: nfont, size: sfont)
                cell.playerLabel.font = UIFont(name: nfont, size: sfont)
                cell.recentLabel.font = UIFont(name: nfont, size: sfont)
                cell.averageLabel.font = UIFont(name: nfont, size: sfont)
                cell.recent3Label.font = UIFont(name: nfont, size: sfont)
                cell.average3Label.font = UIFont(name: nfont, size: sfont)
                cell.pointsLabel.font = UIFont(name: nfont, size: sfont)
                
            } else {
                
                let sfont:CGFloat = 15
                let nfont: String = "ArialMT"
                
                cell.rankLabel.text = String(calcul.standen[indexPath.row-1].ranking + 1)
                cell.playerLabel.text = String(calcul.standen[indexPath.row-1].user)
                cell.recentLabel.text = "2"
                cell.averageLabel.text = "1.2"
                cell.recent3Label.text = "5"
                cell.average3Label.text = "3.1"
                cell.pointsLabel.text = String(calcul.standen[indexPath.row-1].punten)
                
                cell.rankLabel.font = UIFont(name: nfont, size: sfont)
                cell.playerLabel.font = UIFont(name: nfont, size: sfont)
                cell.recentLabel.font = UIFont(name: nfont, size: sfont)
                cell.averageLabel.font = UIFont(name: nfont, size: sfont)
                cell.recent3Label.font = UIFont(name: nfont, size: sfont)
                cell.average3Label.font = UIFont(name: nfont, size: sfont)
                cell.pointsLabel.font = UIFont(name: nfont, size: sfont)
                
            }

        } else {

            cell.rankLabel.text = ""
            cell.playerLabel.text = ""
            cell.recentLabel.text = ""
            cell.averageLabel.text = ""
            cell.recent3Label.text = ""
            cell.average3Label.text = ""
            cell.pointsLabel.text = ""
            
        }
                        
        cell.rankLabel.textAlignment = .center
        cell.recentLabel.textAlignment = .center
        cell.averageLabel.textAlignment = .center
        cell.recent3Label.textAlignment = .center
        cell.average3Label.textAlignment = .center
        cell.pointsLabel.textAlignment = .center

        cell.rankLabel.adjustsFontSizeToFitWidth = true
        cell.playerLabel.adjustsFontSizeToFitWidth = true
        cell.recentLabel.adjustsFontSizeToFitWidth = true
        cell.averageLabel.adjustsFontSizeToFitWidth = true
        cell.recent3Label.adjustsFontSizeToFitWidth = true
        cell.average3Label.adjustsFontSizeToFitWidth = true
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
    
}
