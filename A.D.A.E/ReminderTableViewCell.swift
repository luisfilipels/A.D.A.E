//
//  ReminderTableViewCell.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit
import EventKit
import Foundation
import UserNotifications

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var reminderLabel: UILabel!
    
    var startTime : Date?
    var endTime : Date?
    
    var eventStore = EKEventStore()
    var calendars: Array<EKCalendar> = []
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        sendNotification()
        
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {(granted, error) in
            if !granted {
                print("Access to store not granted!")
            }
        })
        
        calendars = eventStore.calendars(for: EKEntityType.reminder)
        
        startTimeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        endTimeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        timeView.layer.cornerRadius = 10
        timeView.layer.shadowOffset = CGSize(width: 0, height: 3)
        timeView.layer.shadowRadius = 1
        timeView.layer.shadowOpacity = 1
        timeView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.06)
        
        reminderButton.layer.cornerRadius = 10
        reminderButton.clipsToBounds = true
        
        if let date = UserDefaults.standard.object(forKey: "startHour") as? Date {
            startTime = date
        }
        
        if let date = UserDefaults.standard.object(forKey: "endHour") as? Date {
            endTime = date
        }
        
        if let startTime = self.startTime {
            let componentsStart = Calendar.current.dateComponents([.hour, .minute], from: startTime)
            let hour2 = componentsStart.hour!
            let minute2 = componentsStart.minute!
            self.startTimeButton.setTitle("\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))", for: .normal)
        }
        
        if let endTime = self.endTime {
            let componentsEnd = Calendar.current.dateComponents([.hour, .minute], from: endTime)
            let hour2 = componentsEnd.hour!
            let minute2 = componentsEnd.minute!
            self.endTimeButton.setTitle("\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))", for: .normal)
        }
        // Initialization code
    }
    
    @IBAction func startPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Horário do início", message: "Escolha um horário para iniciar seus estudos.\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let pickerFrame = CGRect(x: 17, y: 52, width: 270, height: 250)
        
        let picker = UIDatePicker(frame: pickerFrame)
        picker.datePickerMode = .time
        picker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        alert.view.addSubview(picker)
        
        let action1 = UIAlertAction(title: "Confirmar", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
            let selectedDate = picker.date
            self.startTime = selectedDate
            
            let componentsStart = Calendar.current.dateComponents([.hour, .minute], from: self.startTime!)
            let hour = componentsStart.hour!
            let minute = componentsStart.minute!
        self.startTimeButton.setTitle("\(String(format: "%02d", hour)):\(String(format: "%02d", minute))", for: .normal)
            
            if let startTime = self.startTime,
                let endTime = self.endTime {
                if startTime > endTime {
                    self.reminderLabel.text = "Horário inválido (inicio maior que fim). Alterações não salvas."
                    self.reminderLabel.textColor = .systemRed
                } else {
                    self.reminderLabel.text = "Este é o horário calculado para seus estudos hoje. Clique para alterar."
                    self.reminderLabel.textColor = UIColor(displayP3Red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
                    UserDefaults.standard.set(self.startTime, forKey: "startHour")
                }
            }
            
            alert.dismiss(animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancelar");
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func endPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Horário do fim", message: "Escolha um horário para finalizar seus estudos.\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let pickerFrame = CGRect(x: 17, y: 52, width: 270, height: 250)
        
        let picker = UIDatePicker(frame: pickerFrame)
        picker.datePickerMode = .time
        picker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        alert.view.addSubview(picker)
        
        let action1 = UIAlertAction(title: "Confirmar", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
            let selectedDate = picker.date
            self.endTime = selectedDate
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: self.endTime!)
            let hour = components.hour!
            let minute = components.minute!
            self.endTimeButton.setTitle("\(String(format: "%02d", hour)):\(String(format: "%02d", minute))", for: .normal)
            
            if let startTime = self.startTime,
                let endTime = self.endTime {
                if startTime > endTime {
                    self.reminderLabel.text = "Horário inválido (inicio maior que fim). Alterações não salvas."
                    self.reminderLabel.textColor = .systemRed
                } else {
                    self.reminderLabel.text = "Este é o horário calculado para seus estudos hoje. Clique para alterar."
                    self.reminderLabel.textColor = UIColor(displayP3Red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
                    UserDefaults.standard.set(self.startTime, forKey: "startHour")
                }
            }
            
            UserDefaults.standard.set(self.endTime, forKey: "endHour")

            alert.dismiss(animated: true, completion: nil)
            
        }
        let action2 = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancelar");
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateButtonTitles() {
        print(startTime, endTime)
        if let startTime = self.startTime {
            let componentsStart = Calendar.current.dateComponents([.hour, .minute], from: startTime)
            let hour2 = componentsStart.hour!
            let minute2 = componentsStart.minute!
            self.startTimeButton.titleLabel?.text = "\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))"
        }
        
        if let endTime = self.endTime {
            let componentsEnd = Calendar.current.dateComponents([.hour, .minute], from: endTime)
            let hour2 = componentsEnd.hour!
            let minute2 = componentsEnd.minute!
            self.endTimeButton.titleLabel?.text = "\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))"
        }
    }
    
    @IBAction func reminderButtonPressed(_ sender: Any) {
        let reminder = EKReminder(eventStore: self.eventStore)
        
        
        if (endTime != nil && startTime != nil && startTime! < endTime!) {
            sendNotification()
        }
        
        
        reminder.title = "Hora de estudar!"
        reminder.calendar = eventStore.defaultCalendarForNewReminders()
        
        do {
            try eventStore.save(reminder, commit: true)
        } catch let error {
            print("Failed to set reminder!")
        }
    }
    
    func sendNotification() {
        
        let contentStart = UNMutableNotificationContent()
        contentStart.title = "Hora de estudar!"
        contentStart.subtitle = "enviado do A.D.A.E"
        contentStart.body = "Seu horário para estudos começou."
        
        let contentEnd = UNMutableNotificationContent()
        contentEnd.title = "Hora de descansar!"
        contentEnd.subtitle = "enviado do A.D.A.E"
        contentEnd.body = "Seu horário para descanso começou."
        
        var dateComponentsStart = DateComponents()
        var dateComponentsEnd = DateComponents()
        let calendar = Calendar.current
        
        let hourStart = calendar.component(.hour, from: startTime!)
        let minuteStart = calendar.component(.minute, from: startTime!)
        
        let hourEnd = calendar.component(.hour, from: endTime!)
        let minuteEnd = calendar.component(.minute, from: endTime!)
        
        dateComponentsStart.hour = hourStart
        dateComponentsStart.minute = minuteStart
        dateComponentsStart.weekday = 6 // Monday
        
        dateComponentsEnd.hour = hourEnd
        dateComponentsEnd.minute = minuteEnd
        dateComponentsEnd.weekday = 6
        
        // 3
        let triggerStart = UNCalendarNotificationTrigger(dateMatching: dateComponentsStart, repeats: false)
        let requestStart = UNNotificationRequest(identifier: "notification.id.01", content: contentStart, trigger: triggerStart)
        
        let triggerEnd = UNCalendarNotificationTrigger(dateMatching: dateComponentsEnd, repeats: false)
        let requestEnd = UNNotificationRequest(identifier: "notification.id.02", content: contentEnd, trigger: triggerEnd)
        
        // 4
        UNUserNotificationCenter.current().add(requestStart) { (error) in
            print(error)
        }
        
        UNUserNotificationCenter.current().add(requestEnd) { (error) in
            print(error)
        }
    }
    
}
