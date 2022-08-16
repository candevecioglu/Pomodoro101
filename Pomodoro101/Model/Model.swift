//
//  Model.swift
//  Pomodoro101
//
//  Created by M. Can Devecioğlu on 15.08.2022.
//

import Foundation
import AVFoundation

struct Model {
    
    var player : AVAudioPlayer!
    
    mutating func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    mutating func ambientSound (ambient: String, soundMessage: String) {
        let url = Bundle.main.url(forResource: ambient, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()

    }
    
}
