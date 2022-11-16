//
//  RootViewController.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import CoreML
import TabPageScrollViewController
import UIKit

@available(iOS 11.0, *)
final class RootViewControler: TabPageScrollViewController {
    override func viewDidLoad() {
        
        let standardAppearance = UINavigationBarAppearance()
        
        // Title font color
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // prevent Nav Bar color change on scroll view push behind NavBar
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.systemBlue
        
        
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        navigationController?.navigationBar.topItem?.title = "Qatar 2022"
        
        //navigationController?.navigationBar.barTintColor = .green
        //navigationController?.navigationBar.backgroundColor = .systemBrown
        
        //navigationController?.navigationBar.backgroundColor = .systemRed
        //view.backgroundColor = .red
        
        delegate = self
                
        let vc1:ViewController1 = storyboard!.instantiateViewController(withIdentifier: ViewController1.identifer) as! ViewController1
        vc1.number = 1
        vc1.navigationItem.title = "Live"
        
        let vc2:ViewController2 = storyboard!.instantiateViewController(withIdentifier: ViewController2.identifer) as! ViewController2
        vc2.number = 2
        vc2.navigationItem.title = "Pronos"
        let vc3:ViewController3 = storyboard!.instantiateViewController(withIdentifier: ViewController3.identifer) as! ViewController3
        vc3.number = 3
        vc3.navigationItem.title = "Ranking"
        
        tabItems = [TabItem(title: "Live",vc: vc1),
                         TabItem(title: "Pronos",vc: vc2),
                         TabItem(title: "Ranking",vc: vc3)]
        
        //view.backgroundColor = .blue
        tabHeight = 50
        super.viewDidLoad()
        tabBackgroundColor = .black
        register(nibName: "CategoryCell", reuseIdentifier: "CategoryCell")
        
    }
}

@available(iOS 11.0, *)
extension RootViewControler: TabPageDelegate {

    func categoryView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, selected: Int) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        cell.title.text = tabItems[indexPath.row].title
        cell.tag = indexPath.row
        
            
        if selected == indexPath.row {
            cell.title.textColor = UIColor(red: 69 / 255, green: 134 / 255, blue: 255 / 255, alpha: 1.0)
        } else {
            cell.title.textColor = .lightGray
        }
        return cell
    }

    func categoryView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func willScrollPage(index: Int, viewController: UIViewController) {
        // Index: start page
        // ViewController: end page
        
        let tab = viewController.navigationItem.title
        
        switch tab {
        case "Tab 1":
            let vc:ViewController1 = viewController as! ViewController1
            print ("Index: \(index) viewController: \(vc.number)")
        case "Tab 2":
            let vc:ViewController2 = viewController as! ViewController2
            print ("Index: \(index) viewController: \(vc.number)")
        case "Tab 3":
            let vc:ViewController3 = viewController as! ViewController3
            print ("Index: \(index) viewController: \(vc.number)")
        default:
            print("Invalid tab")
        }
        
        //let vc:ViewController1 = viewController as! ViewController1
         
        //print ("First, index: \(index) viewController: \(vc.number)")
    }
    
    func didScrollPage(index: Int, viewController: UIViewController) {
        // Index: end page
        // ViewController: start page
        
        let tab = viewController.navigationItem.title
        
        switch tab {
        case "Tab 1":
            let vc:ViewController1 = viewController as! ViewController1
            print ("Index: \(index) viewController: \(vc.number)")
        case "Tab 2":
            let vc:ViewController2 = viewController as! ViewController2
            print ("Index: \(index) viewController: \(vc.number)")
        case "Tab 3":
            let vc:ViewController3 = viewController as! ViewController3
            print ("Index: \(index) viewController: \(vc.number)")
        default:
            print("Invalid tab")
        }
            
    }
    
    func tabChangeNotify(index: IndexPath, vc: UIViewController) {
        print ("A-index: \(index)")
    }
    
    func moveNavigationNotify(index: IndexPath) {
        print ("B-index: \(index)")
    }
}
