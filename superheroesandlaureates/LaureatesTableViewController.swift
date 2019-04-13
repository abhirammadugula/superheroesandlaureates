//
//  LaureatesTableViewController.swift
//  superheroesandlaureates
//
//  Created by Student on 4/13/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Laureates.shared.fetchLaureates()
        NotificationCenter.default.addObserver(self, selector: #selector(laureatesRetrieved), name: Notification.Name("Laureates Retrieved"), object: nil)
    }
    
    @objc func laureatesRetrieved(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LAUREATES"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Laureates.shared.numofLas()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureates", for: indexPath)
        let laureate = Laureates.shared[indexPath.row]
        let title = cell.viewWithTag(100) as! UILabel
        let subtitle = cell.viewWithTag(200) as! UILabel
        title.text = "\(laureate.firstName) \(laureate.surName)"
        subtitle.text = "\(laureate.bornDate) \(laureate.diedDate)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
