//
//  DayStepViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit
import EventKit
import Foundation

class DayStepViewController: UIViewController {
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var quoteText: UILabel!
    @IBOutlet weak var quoteAuthor: UILabel!
    
    
    
    static let selfController = self
    
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
        
        
        
        QuoteRepository.getQuote() { quoteResponse in
            DispatchQueue.main.async {
                self.quoteText.text = "\(quoteResponse.quote)"
                self.quoteAuthor.text = "- \(quoteResponse.author)"
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (classTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? ReminderTableViewCell) != nil {
            //cell.endTimeButton.titleLabel?.text = "teste"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "editLectureSegue",
            let destination = segue.destination as? EditLectureViewController,
            let materia = sender as? String
        {
            destination.title = materia
        }
    }
    
}

extension DayStepViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // let disciplinaSelecionada: Disciplina = disciplinas[indexPath.row]
            self.performSegue(withIdentifier: "editLectureSegue", sender: "Matéria")
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function)
    }
    
    
}
