//
//  ViewController.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

// Jupiler Pro League ==> 144
// World Cup ==> 1

import UIKit
import CoreXLSX

public var LiveGamesA = [Match]()
public var FixturesA = [Match]()
public var PronosB = [[Match]]()

public let pr:Int = 43
// Number of players
public let ga:Int = 51
//Number of matches

public let font0 = "Optima-Regular"
public let font2 = "Menlo"
public let font1 = "Monaco"

public let backgroundcolor1: UIColor = UIColor(red: 242/255, green: 241/255, blue: 255/255, alpha: 1)
public let backgroundcolor2: UIColor = UIColor(red: 152/255, green: 247/255, blue: 255/255, alpha: 1)

public var dummy1 = 0

final class ViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return FixturesA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"LiveTableViewCell", for: indexPath) as! LiveGamesCell
        
        if indexPath.row <= FixturesA.count {
        
            cell.homeTeamLabel.text = String(FixturesA[indexPath.row].team1!)
            cell.awayTeamLabel.text = String(FixturesA[indexPath.row ].team2!)
            cell.homegoalsLabel.text = String(FixturesA[indexPath.row].goals1)
            cell.awaygoalsLabel.text = String(FixturesA[indexPath.row].goals2)
            
            cell.homeTeamLabel.font = UIFont(name: font0, size: 10)
            cell.awayTeamLabel.font = UIFont(name: font0, size: 10)
            cell.homegoalsLabel.font = UIFont(name: font0, size: 10)
            cell.awaygoalsLabel.font = UIFont(name: font0, size: 10)
            
        } else {
            cell.homeTeamLabel.text = ""
            cell.awayTeamLabel.text = ""
            cell.homegoalsLabel.text = ""
            cell.awaygoalsLabel.text = ""
            
        }
        
        cell.homegoalsLabel.textAlignment = .center
        cell.awaygoalsLabel.textAlignment = .center
        
        return cell
    }
    
    static let identifer = "ViewController1"
    
    var number: Int = 0
    static let idc: Int = 1

    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var upperBar: UIView!
    
    @IBOutlet weak var UpperBarLabel11: UILabel!
    @IBOutlet weak var UpperBarLabel12: UILabel!
    @IBOutlet weak var UpperBarLabel13: UILabel!
    @IBOutlet weak var UpperBarLabel14: UILabel!
    @IBOutlet weak var UpperBarLabel15: UILabel!
    @IBOutlet weak var UpperBarLabel16: UILabel!
    @IBOutlet weak var UpperBarLabel21: UILabel!
    @IBOutlet weak var UpperBarLabel22: UILabel!
    @IBOutlet weak var UpperBarLabel23: UILabel!
    @IBOutlet weak var UpperBarLabel24: UILabel!
    @IBOutlet weak var UpperBarLabel25: UILabel!
    @IBOutlet weak var UpperBarLabel26: UILabel!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewWillAppear(_ animated: Bool) {
                
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.refreshControl = UIRefreshControl()
        tableView1.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        if dummy1 == 0 {
            // Only load players' predictions once
            realpronos()
            dummy1 = 1
        }
        
        initiate()
        tableView1.reloadData()
        
    }
    
    @objc private func didPullToRefresh() {
        
        initiate()
        
    }
    
    func initiate() {
        
        self.fixtureParsing()
        self.liveGamesParsing()

        
    }
    
}

