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

//public var LiveGamesA = [Match]()
//public var FixturesA = [Match]()
//public var PronosB = [[Match]]()

public var LiveGamesA = [Fixtures]()
public var FixturesA = [Fixtures]()
public var PronosB = [[Fixtures]]()
public var StandenA = [Scores]()
public var StandingsA = [Standings]()

public let pr:Int = 43
// Number of players
public let ga:Int = 51
//Number of matches (change to 64)
public let fr:Int = 0
//Match index start tournament
public let sr:Int = 36
//Match index number 2nd round (change to 48)
public let qf:Int = 44
//start quarter finals (change to 56)
public let sf:Int = 48
//start semi finals (change to 60)
public let f:Int = 50
//start finals (change to 62)

public let font0 = "Optima-Regular"
public let font2 = "Menlo"
public let font1 = "Monaco"

public let backgroundcolor1: UIColor = UIColor(red: 242/255, green: 241/255, blue: 255/255, alpha: 1)
public let backgroundcolor2: UIColor = UIColor(red: 152/255, green: 247/255, blue: 255/255, alpha: 1)

public var dummy1 = 0

public var groupsPlayed = [Int]()
//Matrix returning total games played from group 1 to 8

public var qual16 = [String]()
// best 2 from each group that qualify for round of 16


public var calcul = CalculModel(fixtures: FixturesA, pronos: PronosB, standen: StandenA, standings: StandingsA)
// Initiate calculation object

final class ViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return calcul.standen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"StandenTableViewCell", for: indexPath) as! StandenCell
        
        if indexPath.row <= calcul.standen.count {
        
            cell.standLabel.text = String(calcul.standen[indexPath.row].ranking + 1)
            cell.naamLabel.text = String(calcul.standen[indexPath.row].user)
            cell.scoreLabel.text = String(calcul.standen[indexPath.row].punten)
            
            let temp0 = calcul.standen[indexPath.row].index
            let temp1 = String(calcul.pronos[temp0][1].goals_1) + "-" + String(calcul.pronos[temp0][1].goals_2)
            
            cell.extraLabel.text = temp1
            
            //cell.homeTeamLabel.font = UIFont(name: font0, size: 10)
            //cell.awayTeamLabel.font = UIFont(name: font0, size: 10)
            //cell.homegoalsLabel.font = UIFont(name: font0, size: 10)
            //cell.awaygoalsLabel.font = UIFont(name: font0, size: 10)
            
        } else {
            cell.standLabel.text = ""
            cell.naamLabel.text = ""
            cell.scoreLabel.text = ""
            cell.extraLabel.text = ""
            
        }
        
        cell.standLabel.textAlignment = .center
        cell.scoreLabel.textAlignment = .center
        cell.extraLabel.textAlignment = .center
        
        cell.extraLabel.adjustsFontSizeToFitWidth = true
        
        // Visuals
        cell.ViewStandenCell.layer.cornerRadius = cell.ViewStandenCell.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
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
        
        // Visuals TableView
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        
        if dummy1 == 0 {
            // Only load players' predictions once + Create users standings matrix
            realpronos()
            
            //TEMP
            self.realpronos_temp()
            
            dummy1 = 1
        }
        
        parsing()
        //initiate()
        //tableView1.reloadData()
        
    }
    
    @objc private func didPullToRefresh() {
        
        parsing()
        //initiate()
        
    }
    
    func parsing() {

        //TEM uncomment following line
        //self.fixtureParsing()
        self.liveGamesParsing()
        self.standingParsing()

    }
    
    func initiate() {
        
        // At this point, following arrays have been populated:
        // LiveGamesA = [Fixtures](); FixturesA = [Fixtures]();
        // PronosB = [[Fixtures]](); StandenA = [Scores](); StandingsA = [Standings]()
        
        if FixturesA.count > 0 && PronosB.count > 0 && StandenA.count > 0 && StandingsA.count > 0 {
            
            
            // Update inputs in calcul object
            calcul.fixtures = FixturesA
            calcul.pronos = PronosB
            calcul.standings = StandingsA
            calcul.standen = StandenA
            
            calcul.routine()
            
            for i in 0...StandenA.count-1 {
    
                print(StandenA[i].user)
    
            }
            
        }

        
        //self.test1()
        //StandenA[2].user = "Pipo de clown"
        tableView1.reloadData()
        
        
    }
    
}

