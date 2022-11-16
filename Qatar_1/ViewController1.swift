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
public var UpcomingGamesA = [Fixtures]()
public var FixturesA = [Fixtures]()
public var PronosB = [[Fixtures]]()
public var StandenA = [Scores]()
public var StandingsA = [Standings]()
public var FlagsA: [String: UIImage] = ["Standard Liege": UIImage(named: "Record")!, "Gent": UIImage(named: "Record")!, "Charleroi": UIImage(named: "Record")!, "AS Eupen": UIImage(named: "Record")!, "Kortrijk": UIImage(named: "Record")!, "OH Leuven": UIImage(named: "Record")!, "Zulte Waregem": UIImage(named: "Record")!, "Seraing United": UIImage(named: "Record")!, "St. Truiden": UIImage(named: "Record")!, "Union St. Gilloise": UIImage(named: "Record")!, "Club Brugge KV": UIImage(named: "Record")!, "Genk": UIImage(named: "Record")!, "KV Mechelen": UIImage(named: "Record")!, "Antwerp": UIImage(named: "Record")!, "Anderlecht": UIImage(named: "Record")!, "Oostende": UIImage(named: "Record")!, "KVC Westerlo": UIImage(named: "Record")!, "Cercle Brugge": UIImage(named: "Record")!]

public let pr:Int = 15
// Number of players
public let ga:Int = 64
//Number of matches
public let fr:Int = 0
//Match index start tournament
public let sr:Int = 48
//Match index number 2nd round
public let qf:Int = 56
//start quarter finals
public let sf:Int = 60
//start semi finals
public let f:Int = 62
//start finals

public var sel:Int = 1
public var ran:Int = 1
public var d1: Int = 0

public let font0 = "Optima-Regular"
public let font2 = "Menlo"
public let font1 = "Monaco"

public let backgroundcolor1: UIColor = UIColor(red: 242/255, green: 241/255, blue: 255/255, alpha: 1)
public let backgroundcolor2: UIColor = UIColor(red: 152/255, green: 247/255, blue: 255/255, alpha: 1)

public var dummy1 = 0
public var dummy2 = 0

public var groupsPlayed = [Int]()
//Matrix returning total games played from group 1 to 8

public var qual16 = [String]()
// best 2 from each group that qualify for round of 16

let shortTeams = [
    "Qatar": "QAT", "Ecuador": "ECU", "England": "ENG", "Iran": "IRA", "Senegal": "SEN", "Netherlands": "NLD", "USA": "USA", "Wales": "WAL", "Argentina": "ARG", "Saudi Arabia": "SAU", "Denmark": "DEN", "Tunisia": "TUN", "Mexico": "MEX", "Poland": "POL", "France": "FRA", "Australia": "AUS", "Morocco": "MOR", "Croatia": "CRO", "Germany": "GER", "Japan": "JAP", "Spain": "SPA", "Costa Rica": "COS", "Belgium": "BEL", "Canada": "CAN", "Switzerland": "SWI", "Cameroon": "CAM", "Uruguay": "URU", "South Korea": "KOR", "Portugal": "POR", "Ghana": "GHA", "Brazil": "BRA", "Serbia": "SER"
]

//let shortTeams = [
//    "Standard Liege": "STA", "Gent": "KAA", "Charleroi": "CHA", "AS Eupen": "EUP", "Kortrijk": "KVK", "OH Leuven": "OHL", "Zulte Waregem": "ZWA", "Seraing United": "SER", "St. Truiden": "STV", "Union St. Gilloise": "USG", "Club Brugge KV": "CLU", "Genk": "GNK", "KV Mechelen": "KVM", "Antwerp": "ANT", "Anderlecht": "AND", "Oostende": "KVO", "KVC Westerlo": "WES", "Cercle Brugge": "CER"
//]



public var calcul = CalculModel(fixtures: FixturesA, pronos: PronosB, standen: StandenA, standings: StandingsA)
// Initiate calculation object

final class ViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return calcul.standen.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if calcul.standen.count > 0  {
            
            if indexPath.row != 0 {
                
                sel = calcul.standen[indexPath.row-1].index
                ran = calcul.standen[indexPath.row-1].ranking
                d1 = 1
                
            } else {
                
                d1 = 0
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"StandenTableViewCell", for: indexPath) as! StandenCell
        
        var backgroundD: UIColor = .systemBackground
        var labelD: UIColor = .black
        
        if indexPath.row == 0 {
            // Header row
            backgroundD = .systemBackground
        } else if indexPath.row == 1 {
            //backgroundD = .systemYellow
            backgroundD = UIColor(red: 0.9882, green: 0.7922, blue: 0.1569, alpha: 1.0)
        } else if indexPath.row == 2 {
            //backgroundD = .green
            backgroundD = UIColor(red: 0.9882, green: 0.8431, blue: 0.3647, alpha: 1.0)
        } else if indexPath.row == 3 {
            //backgroundD = .lightGray
            backgroundD = UIColor(red: 0.9882, green: 0.8784, blue: 0.5216, alpha: 1.0)
        } else if indexPath.row == calcul.standen.count - 1 || indexPath.row == calcul.standen.count {
            //backgroundD = .lightGray
            backgroundD = .systemGray4
        } else {
            backgroundD = .systemGray6
        }
        
        if labelD == .black {
            
            labelD =  UIColor { tc in
                     switch tc.userInterfaceStyle {
                     case .dark:
                         return UIColor.white
                     default:
                         return UIColor.black
                     }
                }
        }
        
        if indexPath.row <= calcul.standen.count {
        
            if indexPath.row == 0 {
                
                cell.standLabel.text = "Rank"
                cell.naamLabel.text = "Player"
                cell.scoreLabel.text = "Score"
                
                if LiveGamesA.count > 0 {
                    cell.extraLabel.text = "Prono"
                } else {
                    cell.extraLabel.text = "Recent"
                }
                
                let font01: String = "Arial-BoldMT"
                
                cell.standLabel.font = UIFont(name: font01, size: 17)
                cell.naamLabel.font = UIFont(name: font01, size: 17)
                cell.scoreLabel.font = UIFont(name: font01, size: 17)
                cell.extraLabel.font = UIFont(name: font01, size: 17)
                
                cell.backgroundColor = backgroundD
                cell.extraLabel.backgroundColor = backgroundD
                cell.extraLabel.textColor = labelD
                
            } else {
                
                cell.standLabel.text = String(calcul.standen[indexPath.row-1].ranking + 1)
                cell.naamLabel.text = String(calcul.standen[indexPath.row-1].user)
                cell.scoreLabel.text = String(calcul.standen[indexPath.row-1].punten)
                
                //let temp0 = calcul.standen[indexPath.row-1].index
                
                //var temp1 = String(calcul.pronos[temp0][calcul.lastgame1+1].goals_1) + "-" + String(calcul.pronos[temp0][calcul.lastgame1+1].goals_2)
                
                if LiveGamesA.count == 2 {
                    
                    let a = String(calcul.standen[indexPath.row-1].extra)
                    let b = String(calcul.standen[indexPath.row-1].extra2)
                    
                    print(a)
                    print(b)
                    
                    cell.extraLabel.text = a + "  " + b
                    
                    
                } else {
                   
                    cell.extraLabel.text = String(calcul.standen[indexPath.row-1].extra)
                    
                }
                
                //cell.extraLabel.text = String(calcul.standen[indexPath.row-1].extra)
                
                let meta: String = String(calcul.standen[indexPath.row-1].extra_meta)
                
                var meta2: String = ""
                
                if LiveGamesA.count == 2 {
                 
                    meta2 = String(calcul.standen[indexPath.row-1].extra_meta2)
                    
                }
                
                if meta == "Perfect Guess" || meta2 == "Perfect Guess"   {
                    
                    cell.extraLabel.textColor = .green
                    cell.extraLabel.backgroundColor = .black
                    
                } else if meta == "Perfect Prediction" || meta2 == "Perfect Prediction" {
                    
                    cell.extraLabel.textColor = .white
                    cell.extraLabel.backgroundColor = .darkGray
                    
                } else if meta == "Both Qualified" || meta2 == "Both Qualified" {
                    
                    cell.extraLabel.textColor = .black
                    cell.extraLabel.backgroundColor = .white
                    
                } else if meta == "Burn" || meta2 == "Burn" {
                    
                    cell.extraLabel.textColor = .gray
                    cell.extraLabel.backgroundColor = backgroundD
                    
                } else {
                    
                    cell.extraLabel.textColor = labelD
                    cell.extraLabel.backgroundColor = backgroundD
                    
                }
                                
                let font02: String = "ArialMT"
                
                cell.standLabel.font = UIFont(name: font02, size: 17)
                cell.naamLabel.font = UIFont(name: font02, size: 17)
                cell.scoreLabel.font = UIFont(name: font02, size: 17)
                cell.extraLabel.font = UIFont(name: font02, size: 17)
                
            }

        } else {
            cell.standLabel.text = ""
            cell.naamLabel.text = ""
            cell.scoreLabel.text = ""
            cell.extraLabel.text = ""
            
        }
        
        //Colors
        cell.ViewStandenCell.backgroundColor = backgroundD
        
        cell.standLabel.textAlignment = .center
        cell.scoreLabel.textAlignment = .center
        cell.extraLabel.textAlignment = .center
        
        cell.extraLabel.adjustsFontSizeToFitWidth = true
        
        // Visuals
        cell.ViewStandenCell.layer.cornerRadius = cell.ViewStandenCell.frame.height / 8
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(45)
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
        
        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
        
        if dummy1 == 0 {
            // Only load players' predictions once + Create users standings matrix
            realpronos()
            
            //TEMP
            //self.realpronos_temp()
            
            dummy1 = 1
        }
        
        parsing()
        initiate()
        tableView1.reloadData()
        
    }
    
    @objc private func didPullToRefresh() {
        
        parsing()
        initiate()
        
    }
    
    func parsing() {

        //TEM uncomment following line
        self.fixtureParsing()
        self.liveGamesParsing()
        //self.upcomingGamesParsing()
        self.standingParsing()

    }
    
    func initiate() {
        
        // At this point, following arrays have been populated:
        // LiveGamesA = [Fixtures](); UpcomingGamesA = [Fixtures]() FixturesA = [Fixtures]();
        // PronosB = [[Fixtures]](); StandenA = [Scores](); StandingsA = [Standings]()
        
        if FixturesA.count > 0 && PronosB.count > 0 && StandenA.count > 0 && StandingsA.count > 0 {
            
            // Update inputs in calcul object
            calcul.fixtures = FixturesA
            calcul.pronos = PronosB
            calcul.standings = StandingsA
            calcul.standen = StandenA
            
            // Define round of 16 qualifiers
            qual16 = calcul.qualbest2()
            
//            print("16de")
//            for i in 0...qual16.count-1 {
//                print(qual16[i])
//            }
            
            // Define last game variable
            calcul.lastgame1 = calcul.lastgame()
            
            // Calculate players' points
            calcul.routine()
            
            // Calculate points averages
            calcul.average()
            
            // Extras standen
            calcul.extra(livegames: LiveGamesA.count)
            
        }

        tableView1.reloadData()
    
    }
    
}


