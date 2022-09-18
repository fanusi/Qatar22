//
//  ViewController.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

// Jupiler Pro League ==> 144
// World Cup ==> 1

import UIKit

public var LiveGamesA = [Match]()
public var FixturesA = [Match]()

public let font0 = "Optima-Regular"
public let font2 = "Menlo"
public let font1 = "Monaco"

public let backgroundcolor1: UIColor = UIColor(red: 242/255, green: 241/255, blue: 255/255, alpha: 1)
public let backgroundcolor2: UIColor = UIColor(red: 152/255, green: 247/255, blue: 255/255, alpha: 1)

public var r = Int.random(in: 0...1)

final class ViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if LiveGamesA.count > 0 {
            print(LiveGamesA[0].team1 ?? "Nix")
        }
        print("Number of rows \(LiveGamesA.count)")

        return LiveGamesA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"LiveTableViewCell", for: indexPath) as! LiveGamesCell
           
        if indexPath.row <= FixturesA.count {
            cell.homeTeamLabel.text = String(LiveGamesA[indexPath.row].team1!)
            cell.awayTeamLabel.text = String(LiveGamesA[indexPath.row].team2!)
            cell.homegoalsLabel.text = String(LiveGamesA[indexPath.row].goals1)
            cell.awaygoalsLabel.text = String(LiveGamesA[indexPath.row].goals2)
            
        } else {
            cell.homeTeamLabel.text = ""
            cell.awayTeamLabel.text = ""
            cell.homegoalsLabel.text = ""
            cell.awaygoalsLabel.text = ""
            
        }
        
        cell.homeTeamLabel.font = UIFont(name: font0, size: 10)
        cell.awayTeamLabel.font = UIFont(name: font0, size: 10)
        cell.homegoalsLabel.font = UIFont(name: font0, size: 10)
        cell.awaygoalsLabel.font = UIFont(name: font0, size: 10)

        //cell.textLabel?.text = "Your score is \(String(r))"
        
        return cell
    }
    
    static let identifer = "ViewController1"
    
    var number: Int = 0
    static let idc: Int = 1

    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        r = Int.random(in: 0...1)
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.refreshControl = UIRefreshControl()
        tableView1.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        print("Number equals \(r)")
        initiate()
        tableView1.reloadData()
        
    }
    
    @objc private func didPullToRefresh() {
        
        initiate()
        
    }
    
    func initiate() {
        
        r = Int.random(in: 0...1)
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //DispatchQueue.main.async() {
            self.LiveGamesParsing()
            //self.tableView1.refreshControl?.endRefreshing()
            //self.tableView1.reloadData()
        //}
        
    }
    
}

