//
//  ViewController.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import UIKit

public let font0 = "Optima-Regular"
public let font2 = "Menlo"
public let font1 = "Monaco"

public let backgroundcolor1: UIColor = UIColor(red: 242/255, green: 241/255, blue: 255/255, alpha: 1)
public let backgroundcolor2: UIColor = UIColor(red: 152/255, green: 247/255, blue: 255/255, alpha: 1)

public let test1: [Int] = [1, 12, 13, 3, 4, 3, 9, 12, 13, 20, 10, 3, 21, 12, 13, 20]
public let test2: [Int] = [2, 2, 3, 3, 12, 13, 18, 19, 20, 12, 1, 10, 2, 11, 4, 3]
public var r = Int.random(in: 0...1)

final class ViewController1: UIViewController, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier: String = ""
        
        if r < 1 {
            identifier = "RankingTableViewCell"
        } else {
            identifier = "LiveTableViewCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier, for: indexPath)
        
        if r < 1 {
            cell.textLabel?.text = "Your score is \(String(test1[indexPath.row]))"
            
            if test1[indexPath.row] > 12 {
                cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
            } else {
                cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
            }
            
        } else {
            cell.textLabel?.text = "Your score is \(String(test2[indexPath.row]))"
        }
        //cell.textLabel?.text = "Your score is \(String(r))"
        cell.detailTextLabel?.text = "Well done"
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
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
        
        tableView1.refreshControl = UIRefreshControl()
        tableView1.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        
        print("Number equals \(r)")
        tableView1.reloadData()
        
    }
    
    @objc private func didPullToRefresh() {
        
        initiate()
        
    }
    
    private func initiate() {
        
        r = Int.random(in: 0...1)
        
        DispatchQueue.main.async() {
            self.tableView1.refreshControl?.endRefreshing()
            self.tableView1.reloadData()
        }
        
    }
    
}

