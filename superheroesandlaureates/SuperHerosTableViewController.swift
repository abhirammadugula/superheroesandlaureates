//
//  SuperHerosTableViewController.swift
//  superheroesandlaureates
//
//  Created by Student on 4/13/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SuperHerosTableViewController: UITableViewController {

    var powers : [String] = []
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
        powers = heros.powers
        var powerData:String = ""
        for i in 0..<powers.count{
            if i == powers.count-1{
                powerData = powerData + "\(powers[i])"
            }else{
                powerData = powerData + "\(powers[i]), "
            }
        }
        cell.textLabel?.text = "\(heros.name) (AKA: \(heros.secretIdentity))"
        cell.detailTextLabel?.text = powerData
        return cell
    }

}

