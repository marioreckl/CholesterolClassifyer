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
import Photos
@available(iOS 11.0, *)
class InitailView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let apiKey = "8d7aced8efa9ce11cca985d203dce5989cc20148"
    let version = "2017-08-10" // use today's date for the most recent version
    var resultString = "Elevated Levels Of Cholesterol NOT Been Detected"
    
    let picker = UIImagePickerController()
    
    var imageURLOLD: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    @IBAction func scan(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
   
   func saveToDocs(image: UIImage) throws -> URL  {
        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageURL = imagePath.appendingPathComponent("\(UUID()).png")
        let jpegData = UIImageJPEGRepresentation(image, 0.35)
        try jpegData?.write(to: imageURL, options: .atomic)
        imageURLOLD = imageURL
        return imageURL
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage//
        print(pickedImage)
        var localUrl = try! saveToDocs(image: pickedImage)//
        picker.dismiss(animated: true, completion: nil)
        analyse(path: localUrl)
    }

    func analyse(path: URL) {
        let busyIndecator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        busyIndecator.backgroundColor = UIColor(white: 1, alpha: 0.25)
        busyIndecator.frame = CGRect(x: 0, y:0, width:  self.view.frame.width, height:  self.view.frame.height)
        busyIndecator.startAnimating()
        self.view.addSubview(busyIndecator)
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let imageSelf = Bundle.main.url(forResource: "download-1", withExtension: "jpg")!//(forResource: path)//Bundle.main.url(forAuxiliaryExecutable: image)
        print(imageSelf);
        
        let failure = { (error: Error) in print(error) }
        let classifierID:[String] = ["Untitled_980185356"]
        print("starting")
        visualRecognition.classify(imageFile: path, classifierIDs: classifierID , language: "en", failure: failure) { classifiedImages in
            DispatchQueue.main.async {
                busyIndecator.stopAnimating()
                busyIndecator.removeFromSuperview()
            }
            print(classifiedImages)
            if (classifiedImages.images.count > 0){
                print(classifiedImages.images)
                print("classification")
                if(classifiedImages.images[0].classifiers.count > 0){ var classification = classifiedImages.images[0].classifiers[0].classes[0].classification
                    
                    if(classification == "Negative"){
                        DispatchQueue.main.async{
                            self.performSegue(withIdentifier: "healthyResults", sender: self)}
                    }
                    else if (classification == "Positive"){
                        self.resultString = "Elevated levels of cholesterol detected, please talk to your doctor about high cholesterol"
                        DispatchQueue.main.async{
                            self.performSegue(withIdentifier: "healthyResults", sender: self)}
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultsView {
            print(resultString)
            vc.result = resultString
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
