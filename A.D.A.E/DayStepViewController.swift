//
//  DayStepViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class DayStepViewController: UIViewController {
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteView.layer.cornerRadius = 10
        quoteView.layer.shadowOffset = CGSize(width: 0, height: 3)
        quoteView.layer.shadowRadius = 1
        quoteView.layer.shadowOpacity = 1
        quoteView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.06)
        // Do any additional setup after loading the view.
        
        classTableView.delegate = self
        classTableView.dataSource = self
        
//        editTimeView.layer.cornerRadius = 10
//        editTimeView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        editTimeView.layer.shadowRadius = 1
//        editTimeView.layer.shadowOpacity = 1
//        editTimeView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.06)
    }

}

extension DayStepViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Aulas de Hoje" : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 250
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 250
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? "Clique em um item para editar/adicionar aula ou horário." : nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClassTimeCell", for: indexPath)
            cell.textLabel?.text = "Matemática"
            cell.detailTextLabel?.text = "08:00 - 12:00"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetReminderCell", for: indexPath) as! ReminderTableViewCell
                        
            return cell
        }

    }
    
    
}
