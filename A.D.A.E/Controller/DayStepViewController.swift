//
//  DayStepViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DayStepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var quoteText: UILabel!
    @IBOutlet weak var quoteAuthor: UILabel!
    
    var lecturesToday: [Lecture]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaults.standard.object(forKey: "firstStart") == nil  || UserDefaults.standard.object(forKey: "firstStart") as? Bool == true{
            UserDefaults.standard.set(false, forKey: "firstStart")
            
            print("Something has happened")
            
            for i in 0..<7 {
                let day = Day(numberOnWeek: i)
            }
            
            var testDayArray = Day.getDay(in: 0)
            var testDay = testDayArray[0]
            
            var firstLectureStartComponents = DateComponents()
            firstLectureStartComponents.hour = 8
            firstLectureStartComponents.minute = 0
            
            var firstLectureEndComponents = DateComponents()
            firstLectureEndComponents.hour = 10
            firstLectureEndComponents.minute = 0
            
            let userCalendar = Calendar.current
            let startHourTime = userCalendar.date(from: firstLectureStartComponents)
            let endHourTime = userCalendar.date(from: firstLectureEndComponents)
            
            let lecture1 = Lecture(name: "SEMB", startTime: startHourTime!, endTime: endHourTime!)
            
            var secondLectureStartComponents = DateComponents()
            secondLectureStartComponents.hour = 14
            secondLectureStartComponents.minute = 0
           
            var secondLectureEndComponents = DateComponents()
            secondLectureEndComponents.hour = 16
            secondLectureEndComponents.minute = 0
           
            let startHourTime2 = userCalendar.date(from: secondLectureStartComponents)
            let endHourTime2 = userCalendar.date(from: secondLectureEndComponents)
            
            let lecture2 = Lecture(name: "Grafos", startTime: startHourTime2!, endTime: endHourTime2!)
            
            testDay.addToClassesInDay(lecture1!)
            testDay.addToClassesInDay(lecture2!)
            
            Day.saveChanges()
        }
        
        let days = Day.getDay(in: 0)
        let lectures = days[0].classesInDay?.allObjects as! [Lecture]
        lecturesToday = lectures
        
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
        return section == 0 ? lecturesToday?.count ?? 0 : 1
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
            cell.textLabel?.text = lecturesToday?[indexPath.row].name ?? " "
            let startTime = lecturesToday?[indexPath.row].startTime
            let endTime = lecturesToday?[indexPath.row].endTime
            
            let df = DateFormatter()
            df.dateFormat = "HH:mm"
            
            cell.detailTextLabel?.text = "\(df.string(from: startTime!)) - \(df.string(from: endTime!))"
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



