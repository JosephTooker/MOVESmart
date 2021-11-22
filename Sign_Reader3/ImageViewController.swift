//
//  ImageViewController.swift
//  Sign_Reader3
//
//  Created by Joseph Tooker on 9/22/21.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import AWSRekognition

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var readLabel: UILabel!
    
    var rekognitionObject:AWSRekognition?
    var imageText: String?
    var viewAppeared = 0
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageText = ""
        
        /*
        let textImage:Data = imageView.image!.jpegData(compressionQuality: 0.2)!
        sendImageToRekognition(textImageData: textImage) */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewAppeared += 1
        
        if (viewAppeared >= 2) {
            let textImage:Data = imageView.image!.jpegData(compressionQuality: 0.2)!
            sendImageToRekognition(textImageData: textImage)
            while (imageText == "") {
                i += 1
            }
            print(i)
            print(imageText)
            self.readLabel.text = self.imageText
        }
        let voice = AVSpeechSynthesisVoice(language: "en-au")
        let toSay = AVSpeechUtterance(string : readLabel.text!)
        toSay.voice = voice
        let speak = AVSpeechSynthesizer()
        speak.speak(toSay)
    }
    
    @IBAction func onTap(_ sender: Any) {
        print("Tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    func sendImageToRekognition(textImageData: Data){
        imageText = ""
        
        //Delete older labels or buttons
        rekognitionObject = AWSRekognition.default()
        let textImageAWS = AWSRekognitionImage()
        textImageAWS?.bytes = textImageData
        let textRequest = AWSRekognitionDetectTextRequest()
        textRequest?.image = textImageAWS
        
        rekognitionObject?.detectText(textRequest!) {
            (result, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if result != nil {
                print(result!)
                //1. First we check if there is any text in the response
                if ((result!.textDetections?.count)! > 0){
                    print(result!.textDetections?.count)
                                    
                    //2. Text was found. Lets iterate through all of it
                    for (index, text) in result!.textDetections!.enumerated(){
                        if(text.confidence?.intValue ?? 0 > 50) {
                            if(result?.textDetections?[index].parentId == nil) {
                                self.imageText! += (result!.textDetections?[index].detectedText)!
                                self.imageText! += " "
                            }
                        }
                    }
                    print(self.imageText as Any)
                }
            }
            else {
                print("No result")
                self.readLabel.text = "No text detected"
            }
        }
        
        
        DispatchQueue.main.async {
            [weak self] in
            for subView in (self?.imageView.subviews)! {
                subView.removeFromSuperview()
            }
        }
        
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
