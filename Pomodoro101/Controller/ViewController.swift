//
//
// That is one giant leap for man, one small step for mankind.
//
//  ViewController.swift
//  Pomodoro101
//
//  Created by M. Can Devecioğlu on 7.08.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player           : AVAudioPlayer!
    var timer            = Timer()
    var totalTime        = 1500
    var showTime         = 1500
    var secondPassed     = 0
    var sessionCompleted = 0
    var constants        = Contants()
    var pomodoroModel    = Model()
    
    @IBOutlet weak var greetingTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBarLabel: UIProgressView!
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var libraryLabel: UIButton!
    @IBOutlet weak var forestLabel: UIButton!
    @IBOutlet weak var rainLabel: UIButton!
    @IBOutlet weak var abientSoundLabel: UILabel!
    @IBOutlet weak var muteLabel: UIButton!
    @IBOutlet weak var completedSessionsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = constants.initialTimeText
        resetButtonLabel.isEnabled = false
        
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressBarLabel.progress  = 0
        showTime                   = 1500
        totalTime                  = 1500
        secondPassed               = 0
        timer                      = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        startButtonLabel.isEnabled = false
        resetButtonLabel.isEnabled = true
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        timeLabel.text             = constants.initialTimeText
        startButtonLabel.isEnabled = true
        greetingTextLabel.text     = constants.greetingAgainText
        progressBarLabel.progress  = 0
        showTime                   = 1500
        secondPassed               = 0
        abientSoundLabel.text      = constants.ambientSound
        player.stop()
        
    }
    
    func dateFormatter () {

        let formatterCounter         = DateComponentsFormatter()
        formatterCounter.unitsStyle  = .positional
        let formattedCounter         = formatterCounter.string(from: TimeInterval(showTime))!
        
        let formatterGreeting        = DateComponentsFormatter()
        formatterGreeting.unitsStyle = .short
        let formattedGreeting        = formatterGreeting.string(from: TimeInterval(secondPassed))!
        greetingTextLabel.text       = "Session started \(formattedGreeting) ago."
        timeLabel.text = String(formattedCounter)
    }
    
    
    @objc func updateCounter () {
        if secondPassed < totalTime {
            secondPassed += 1
            showTime -= 1
            dateFormatter()
            progressBarLabel.progress = Float(secondPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            timeLabel.text              = constants.done
            greetingTextLabel.text      = constants.sessionCompletedOneMore
            startButtonLabel.isEnabled  = true
            sessionCompleted           += 1
            completedSessionsLabel.text = "Completed sessions: \(sessionCompleted)"
            playSound()

        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func libraryButton(_ sender: UIButton) {
        ambientSound(ambient: "library", soundMessage: constants.libraryAmbientText)
    }
    
    @IBAction func forestButton(_ sender: UIButton) {
        ambientSound(ambient: "forest", soundMessage: constants.forestAmbientText)
    }
    
    
    @IBAction func rainButton(_ sender: UIButton) {
        ambientSound(ambient: "rain", soundMessage: constants.rainAmbientText)
    }
    
    @IBAction func muteButton(_ sender: UIButton) {
        abientSoundLabel.text = "Shhh..."
        player.stop()
    }
    
    
    func ambientSound (ambient: String, soundMessage: String) {
        let url = Bundle.main.url(forResource: ambient, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        abientSoundLabel.text = soundMessage
        player.play()

    }
    
}

