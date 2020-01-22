//
//  PomodoroViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

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
    
    let studyTime = 10
    let restTime = 5
    var timeRemaining = 0
    
    var timer = Timer()
    
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.progressViewStyle = .bar
        progressView.setProgress(1, animated: true)
        //startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startPauseButtonPressed(_ sender: Any) {
        if timer.isValid {
            // Trocar desenho do botão
            pauseTimer()
        } else {
            // Trocar desenho também
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
                timeRemaining = studyTime
            } else {
                timeRemaining = restTime
            }
            updateDisplay()
            startTimer()
            currentInterval += 1
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
        
        if (intervals[currentInterval] == .Study) {
            print("Study")
            print(timeRemaining)
            print(studyTime)
            
            let time = (Float(timeRemaining) / Float(studyTime)) - 1.0
            print(time - 1.0)
            progressView.setProgress(time - 1.0, animated: false)
        } else {
            print("Rest")
            print(timeRemaining)
            print(studyTime)
            let time = (Float(timeRemaining) / Float(studyTime))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
