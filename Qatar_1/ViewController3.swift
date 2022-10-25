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
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"FullStandViewCell", for: indexPath) as UITableViewCell
        
        if indexPath.row <= calcul.standen.count {
        
            if indexPath.row == 0 {
                
                cell.textLabel?.text = "Ranking"
                cell.detailTextLabel?.text = "Pts"

                
            } else {
                
                let rank: String = String(calcul.standen[indexPath.row-1].ranking + 1)
                let player: String = String(calcul.standen[indexPath.row-1].user)
                let rpla: String = rank + "  -  " + player
                
                let punten: String = String(calcul.standen[indexPath.row-1].punten)
                
                cell.textLabel?.text = rpla
                cell.detailTextLabel?.text = punten
                
                //cell.scoreLabel.text = String(calcul.standen[indexPath.row-1].punten)
                
                //let temp0 = calcul.standen[indexPath.row-1].index
                
                //var temp1 = String(calcul.pronos[temp0][calcul.lastgame1+1].goals_1) + "-" + String(calcul.pronos[temp0][calcul.lastgame1+1].goals_2)
                
                //cell.extraLabel.text = String(calcul.standen[indexPath.row-1].extra)
                
            }

        } else {
            
            cell.textLabel!.text = ""
            cell.detailTextLabel!.text = ""
            
        }
        
        cell.detailTextLabel!.textAlignment = .center
        cell.detailTextLabel!.adjustsFontSizeToFitWidth = true
        
        // Visuals
        //cell.ViewStandenCell.layer.cornerRadius = cell.ViewStandenCell.frame.height / 8
        
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
