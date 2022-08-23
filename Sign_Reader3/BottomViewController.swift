import UIKit
import AVFoundation
import CoreLocation

var bPlayer: AVAudioPlayer?
var destination: String?

class BottomViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var destinationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var speech = instructionLabel.text
        
        destinationTextField.delegate = self
        
        let voice = AVSpeechSynthesisVoice(language: "en-au")
        let toSay = AVSpeechUtterance(string : speech!)
        toSay.voice = voice
        let speak = AVSpeechSynthesizer()
        speak.speak(toSay)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is BoxViewController {
            let vc = segue.destination as? BoxViewController
            vc?.dest = destinationTextField.text
        }
    }
    
   
}

extension BottomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
     }
}



