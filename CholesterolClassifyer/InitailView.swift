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
class InitailView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let apiKey = "8d7aced8efa9ce11cca985d203dce5989cc20148"
    let version = "2017-08-10" // use today's date for the most recent version
    
    
    let picker = UIImagePickerController()
    
    var imageURLOLD: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    @IBAction func scan(_ sender: Any) {
     if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
     let imagePicker = UIImagePickerController()
     imagePicker.delegate = self
     imagePicker.sourceType = UIImagePickerControllerSourceType.camera
     imagePicker.allowsEditing = false
     self.present(imagePicker, animated: true, completion: nil)
     }
    }
    func saveImage(image: UIImage) -> () {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(path:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(path: String, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer?) {
        //analyse(path: path)
        debugPrint(path) // That's the path you want
    }
    
   /* func saveToDocs(image: UIImage) throws -> URL  {
        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageURL = imagePath.appendingPathComponent("\(UUID()).jpeg")
        let jpegData = UIImageJPEGRepresentation(image, 0.5)
        try jpegData?.write(to: imageURL, options: .atomic)
        imageURLOLD = imageURL
        return imageURL
    }*/
    /*func removeImage() {
        
        let filePath = imageURLOLD
        do {
            try FileManager.default.removeItem(at: filePath!)
        } catch let error as NSError {
            print(error.debugDescription)
        }}*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("here2")
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage//info[UIImagePickerControllerReferenceURL] as? URL

        var path = try! saveToDocs(image: pickedImage)
        analyse(path: path)
        removeImage()
        
        picker.dismiss(animated: true, completion: nil)
    }

    func analyse(path: URL) {
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        print("in")
        
        //let imageSelf = Bundle.main.url(forResource: path, withExtension: "jpg")!//(forResource: path)//Bundle.main.url(forAuxiliaryExecutable: image)
        //print(imageSelf);
        
//        let jsonObject = {
//            "images": image
//        }

        let failure = { (error: Error) in print(error) }
        let classifierID:[String] = ["Untitled_1788328397"]
        print("starting")
        visualRecognition.classify(imageFile: path, classifierIDs: classifierID , language: "en", failure: failure) { classifiedImages in
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
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
