//
//  SuperHerosTableViewController.swift
//  superheroesandlaureates
//
//  Created by Abhiram, Madugula on 4/13/19.
//  Copyright © 2019 Abhiram, Madugula. All rights reserved.
//

import UIKit

class SuperHerosTableViewController: UITableViewController {

    var superpowers : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        SuperHeros.shared.fetchSuperHero()
        NotificationCenter.default.addObserver(self, selector: #selector(herosRetrieved), name: Notification.Name("Heros Retrieved"), object: nil)
    }
    
    @objc func herosRetrieved(){
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SuperHeros"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SuperHeros.shared.members.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superhero", for: indexPath)
        let heros = SuperHeros.shared[indexPath.row]
        superpowers = heros.powers
        var Data:String = ""
        for i in 0..<superpowers.count{
            if i == superpowers.count-1{
                Data = Data + "\(superpowers[i])"
            }else{
                Data = Data + "\(superpowers[i]), "
            }
        }
        cell.textLabel?.text = "\(heros.name) (AKA: \(heros.secretIdentity))"
        cell.detailTextLabel?.text = Data
        return cell
    }

}

