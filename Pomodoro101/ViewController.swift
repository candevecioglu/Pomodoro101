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
    
    var player       : AVAudioPlayer!
    var timer        = Timer()
    var totalTime    = 1500
    var showTime     = 1500
    var secondPassed = 0
    
    @IBOutlet weak var greetingTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBarLabel: UIProgressView!
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var libraryLabel: UIButton!
    @IBOutlet weak var forestLabel: UIButton!
    @IBOutlet weak var rainLabel: UIButton!
    @IBOutlet weak var abientSoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "25:00"
        resetButtonLabel.isEnabled = false
        
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressBarLabel.progress = 0
        showTime     = 1500
        totalTime    = 1500
        secondPassed = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        startButtonLabel.isEnabled = false
        resetButtonLabel.isEnabled = true
        

        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        timeLabel.text = "25:00"
        startButtonLabel.isEnabled = true
        greetingTextLabel.text = "Okey try again I'm ready!"
        progressBarLabel.progress = 0
        showTime     = 1500
        secondPassed = 0
    }
    
    
    @objc func updateCounter() {
        if secondPassed < totalTime {
            secondPassed += 1
            showTime -= 1
            
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            let formattedString = formatter.string(from: TimeInterval(showTime))!
            

            
            let formatter2 = DateComponentsFormatter()
            formatter2.unitsStyle = .short
            let formattedString2 = formatter2.string(from: TimeInterval(secondPassed))!
            
            greetingTextLabel.text = "Session started \(formattedString2) ago."
            
            timeLabel.text = String(formattedString)
            progressBarLabel.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            timeLabel.text = "Done!"
            greetingTextLabel.text = "Session completed! One more?"
            startButtonLabel.isEnabled = true
            playSound()

            
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func libraryButton(_ sender: UIButton) {
        
        let url = Bundle.main.url(forResource: "library", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        abientSoundLabel.text = "You are in the Library shh..."
        player.play()
        
    }
    
    @IBAction func forestButton(_ sender: UIButton) {
        
        let url = Bundle.main.url(forResource: "forest", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        abientSoundLabel.text = "Trees are everywhere!"
        player.play()
        
    }
    
    
    @IBAction func rainButton(_ sender: UIButton) {
        
        let url = Bundle.main.url(forResource: "rain", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        abientSoundLabel.text = "Can you hear the rain? :)"
        player.play()
        
    }
    
}

