//
//  ViewControllerP.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 29/10/2022.
//

import UIKit

class ViewControllerP: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview1: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableview1.dataSource = self
        tableview1.delegate = self
        
        // Visuals TableView
        tableview1.separatorStyle = .none
        tableview1.showsVerticalScrollIndicator = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ga-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PlayerTableViewCell", for: indexPath) as! PlayerCell
        
        cell.playerLabel.text = String(calcul.pronos[sel][indexPath.row].team_1) + " - " + String(calcul.pronos[sel][indexPath.row].team_2)
        cell.predictionLabel.text = String(calcul.pronos[sel][indexPath.row].goals_1) + " - " + String(calcul.pronos[sel][indexPath.row].goals_2)
        cell.tournamentLabel.text = String(calcul.fixtures[indexPath.row].goals_1) + " - " + String(calcul.fixtures[indexPath.row].goals_2)
        cell.pointsLabel.text = String(calcul.fixtures[indexPath.row].punten)
        
        return cell
        
    }
    
    
}
