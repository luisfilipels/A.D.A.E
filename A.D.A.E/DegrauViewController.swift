//
//  DegrauViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class DegrauViewController: UIViewController {

    @IBOutlet weak var tableHeaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableHeaderView.layer.cornerRadius = 10
        //        quoteView.layer.masksToBounds = true
        tableHeaderView.layer.shadowOffset = CGSize(width: 0, height: 5)
        tableHeaderView.layer.shadowRadius = 1
        tableHeaderView.layer.shadowOpacity = 1
        tableHeaderView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
    }
}

extension DegrauViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Matérias" : "Timer"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
            cell.textLabel?.text = "Matemática"
            cell.detailTextLabel?.text = "08:00 - 12:00"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderTableViewCell
            
            return cell
        }
    }
    
    
}

