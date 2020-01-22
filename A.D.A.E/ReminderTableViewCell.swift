//
//  ReminderTableViewCell.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit
import Foundation

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    
    var startTime : Date?
    var endTime : Date?
    
    
    
    override func awakeFromNib() {
        print(#function)
        super.awakeFromNib()
        startTimeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        endTimeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        timeView.layer.cornerRadius = 10
        timeView.layer.shadowOffset = CGSize(width: 0, height: 3)
        timeView.layer.shadowRadius = 1
        timeView.layer.shadowOpacity = 1
        timeView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.06)
        
        reminderButton.layer.cornerRadius = 10
        reminderButton.clipsToBounds = true
        
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
            if let endTime = self.endTime {
                let componentsEnd = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                let hour2 = componentsEnd.hour!
                let minute2 = componentsEnd.minute!
                self.endTimeButton.setTitle("\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))", for: .normal)
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
            self.endTimeButton.titleLabel?.text = "\(String(format: "%02d", hour)):\(String(format: "%02d", minute))"
            alert.dismiss(animated: true, completion: nil)
            
            if let startTime = self.startTime {
                let componentsStart = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let hour2 = componentsStart.hour!
                let minute2 = componentsStart.minute!
                self.startTimeButton.titleLabel?.text = "\(String(format: "%02d", hour2)):\(String(format: "%02d", minute2))"
            }
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
    
    

}
