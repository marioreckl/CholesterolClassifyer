//
//  InitailView.swift
//  CholesterolClassifyer
//
//  Created by Mario Reckl on 2017-11-18.
//  Copyright © 2017 Mario Reckl. All rights reserved.
//

import Foundation
import UIKit
import VisualRecognitionV3
@available(iOS 11.0, *)
class InitailView: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    let apiKey = "8d7aced8efa9ce11cca985d203dce5989cc20148"
    let version = "2017-08-10" // use today's date for the most recent version
    
    
    @IBOutlet var capturePreviewView: UIView!
    
    let cameraController = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        
        configureCameraController()*/
    }
    /*@IBAction func scan(_ sender: Any) {
        print("pressed")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            print("all good")
            //self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }*/
    @IBAction func scan(_ sender: Any) {
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let image = NSURL(fileURLWithPath: "Grey_eye_G5wCD.jpg")
        let imageSelf = Bundle.main.url(forResource: "Grey_eye_G5wCD", withExtension: "jpg")
        print(imageSelf!);
        
//        let jsonObject = {
//            "images": image
//        }

        let failure = { (error: Error) in print(error) }
        let classifierID:[String] = ["Untitled_1788328397"]
        
        visualRecognition.classify(imageFile: imageSelf!, classifierIDs:classifierID , language: "en", failure: failure) { classifiedImages in
            print(classifiedImages)}
        
        /*visualRecognition.classify(classifierID,) { classifiedImages in
            print(classifiedImages)
        }*/
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*visualRecognition.classify(image: "https://www.google.ca/search?q=eye&source=lnms&tbm=isch&sa=X&ved=0ahUKEwj104Wh-MjXAhVCy1QKHXXWBnUQ_AUICigB&biw=1280&bih=726#imgrc=IJ6fjoYvmPagyM:", classifierIDs:classifierID , language: "en", failure: failure) { classifiedImages in
    print(classifiedImages)
    }*/
    
}
