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
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let voice = AVSpeechSynthesisVoice(language: "en-au")
        let toSay = AVSpeechUtterance(string : tapScreen.currentTitle!)
        toSay.voice = voice
        let speak = AVSpeechSynthesizer()
        speak.speak(toSay)
        
    }


}

