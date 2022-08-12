//
//  ViewController.swift
//  Sign_Reader3
//
//  Created by Joseph Tooker on 9/22/21.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {

    @IBOutlet weak var tapScreen: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var speech = tapScreen.titleLabel!.text
        speech! += " "
        speech! += mapButton.titleLabel!.text!
        speech! += " "
        speech! += bottomButton.titleLabel!.text!
        
        
        let voice = AVSpeechSynthesisVoice(language: "en-au")
        let toSay = AVSpeechUtterance(string : speech!)
        toSay.voice = voice
        let speak = AVSpeechSynthesizer()
        speak.speak(toSay)
        
    }


}

