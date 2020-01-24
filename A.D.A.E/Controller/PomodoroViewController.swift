//
//  PomodoroViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

import AVFoundation

class PomodoroViewController: UIViewController {
    
    enum IntervalType {
        case Study
        case Rest
    }
    
    let intervals: [IntervalType] = [
        .Study,
        .Rest,
        .Study,
        .Rest,
        .Study,
        .Rest
    ]
    
    var currentInterval = 0
    
    let studyTime = 30
    let restTime = 15
    var timeRemaining = 0
    
    var timer = Timer()
    
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    @IBOutlet weak var studyRestLabel: UILabel!
    
    @IBOutlet weak var colonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progressViewStyle = .bar
        progressView.setProgress(1, animated: true)
        
        addLongPressGesture()
        
        //startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        if timer.isValid {
            // Trocar desenho do botão
            startPauseButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
            pauseTimer()
            
        } else {
            // Trocar desenho também
            startPauseButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
            if currentInterval == 0 && timeRemaining == studyTime {
                startNextInterval()
            } else {
                startTimer()
            }
        }
    }
    
    func startNextInterval() {
        if currentInterval < intervals.count {
            if intervals[currentInterval] == .Study {
                AudioServicesPlaySystemSound (1336)
                self.startPauseButton.tintColor = .red
                currentInterval += 1
                timeRemaining = studyTime
                self.studyRestLabel.text = "Hora de Estudar!"
                self.minutesLabel.textColor = .black
                self.secondsLabel.textColor = .black
                self.colonLabel.textColor = .black
                self.studyRestLabel.textColor = .black
                self.progressView.progressTintColor = .black
                
            } else {
                AudioServicesPlaySystemSound (1036)
                self.startPauseButton.tintColor = .systemBlue
                currentInterval += 1
                timeRemaining = restTime
                self.studyRestLabel.text = "Hora de Descansar!"
                self.minutesLabel.textColor = .black
                self.secondsLabel.textColor = .black
                self.colonLabel.textColor = .black
                self.studyRestLabel.textColor = .black
                self.progressView.progressTintColor = .black

            }
            updateDisplay()
            
            startTimer()
            
        } else {
            resetToBeginning()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateDisplay()
        } else {
            timer.invalidate()
            startNextInterval()
        }
    }
    
    func pauseTimer() {
        timer.invalidate()
    }
    
    func resetToBeginning () {
        currentInterval = 0
        timeRemaining = studyTime
        updateDisplay()
    }
    
    func updateDisplay () {
        let (minutes, seconds) = minutesAndSeconds(from: timeRemaining)
        minutesLabel.text = formatMinuteOrSecond(minutes)
        secondsLabel.text = formatMinuteOrSecond(seconds)
        
        if (intervals[currentInterval] == .Rest) {
            print("Study")
            print(timeRemaining)
            print(studyTime)
            
            let time = (Float(timeRemaining) / Float(studyTime))
            print(time)
            progressView.setProgress(time, animated: false)
        } else {
            print("Rest")
            print(timeRemaining)
            print(studyTime)
            
            let time = (Float(timeRemaining) / Float(restTime))
            print(time)
            progressView.setProgress(time, animated: false)
        }
    }
    
    func minutesAndSeconds (from seconds: Int) -> (Int, Int) {
        return (seconds/60, seconds % 60)
    }
    
    func formatMinuteOrSecond (_ number: Int) -> String {
        return String(format:"%02d", number)
    }
    
    @objc func longPressReset(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            pauseTimer()
            resetToBeginning()
            startPauseButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
            self.startPauseButton.tintColor = .systemBlue
            self.studyRestLabel.text = "Vamos Estudar?!"
            self.minutesLabel.textColor = .black
            self.secondsLabel.textColor = .black
            self.colonLabel.textColor = .black
            self.studyRestLabel.textColor = .black
            self.progressView.progressTintColor = .black
        }
    }
    
    func addLongPressGesture(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressReset))
        longPress.minimumPressDuration = 1.5
        self.startPauseButton.addGestureRecognizer(longPress)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
