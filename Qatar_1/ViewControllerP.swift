//
//  ViewControllerP.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 29/10/2022.
//

import UIKit

class ViewControllerP: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var nameView: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableview1.dataSource = self
        tableview1.delegate = self
        
        // Visuals TableView
        tableview1.separatorStyle = .none
        tableview1.showsVerticalScrollIndicator = false
        
        if calcul.pronos[0].count > 0 {
            
            nameView.text = String(calcul.pronos[sel][0].user)
            
        } else {
            
            nameView.text = "No Data"
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var c1 = 1
        
        if calcul.pronos[0].count > 0 {
            
            c1 = calcul.pronos[0].count + 1
        }
        
        return c1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PlayerTableViewCell", for: indexPath) as! PlayerCell
        
        if calcul.fixtures.count > 0 {
            
            if indexPath.row == 0 {
                
                cell.gameLabel.text = "Game"
                cell.predictionLabel.text = "Guess"
                cell.pointsLabel.text = "Points"
                cell.averageLabel.text = "Average"
                
            } else {
                
                cell.gameLabel.text = String(calcul.pronos[sel][indexPath.row-1].team_1) + " - " + String(calcul.pronos[sel][indexPath.row-1].team_2)
                cell.predictionLabel.text = String(calcul.pronos[sel][indexPath.row-1].goals_1) + " - " + String(calcul.pronos[sel][indexPath.row-1].goals_2)
                
                if calcul.fixtures[indexPath.row-1].goals_1 == -999 {
                    
                    cell.pointsLabel.text = ""
                    cell.averageLabel.text = ""
                    
                    
                } else {
                    
                    cell.pointsLabel.text = String(calcul.fixtures[indexPath.row-1].punten)
                    cell.averageLabel.text = String(calcul.fixtures[indexPath.row-1].average)
                    
                }
                
            }
            
        } else {
            
            cell.gameLabel.text = ""
            cell.predictionLabel.text = ""
            cell.pointsLabel.text = ""
            cell.averageLabel.text = ""
            
        }
        
//        cell.predictionLabel.textAlignment = .center
//        cell.pointsLabel.textAlignment = .center
//        cell.averageLabel.textAlignment = .center
//
        cell.gameLabel.adjustsFontSizeToFitWidth = true
        cell.predictionLabel.adjustsFontSizeToFitWidth = true
        cell.pointsLabel.adjustsFontSizeToFitWidth = true
        cell.averageLabel.adjustsFontSizeToFitWidth = true
        
        //print(cell.frame.height)

        return cell
        
    }
    
    
}
