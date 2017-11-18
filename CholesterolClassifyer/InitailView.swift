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
    @IBAction func scan(_ sender: Any) {
        print("pressed")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            print("all good")
            //self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
   /* @IBAction func scan(_ sender: Any) {
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let image = #imageLiteral(resourceName: "Grey_eye_G5wCD.jpg")
        let failure = { (error: Error) in print(error) }
        
        /*visualRecognition.classify(imageFile: image, classifierIDs: "Untitled_841215900", failure: failure) { classifiedImages in
            print(classifiedImages)*/
        //}
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   func analyse(){
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let image = "#imageLiteral(resourceName: Grey_eye_G5wCD.jpg)"
        let failure = { (error: Error) in print(error) }
        
        visualRecognition.classify(image: image, failure: failure) { classifiedImages in
            print(classifiedImages)
        }
    }
    
}
