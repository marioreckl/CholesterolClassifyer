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
    func saveImage(image: UIImage) -> () {
       print("save")
       UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
        queryLastPhoto(resizeTo: CGSize.init(width: 500, height: 500))
    }
    
    func queryLastPhoto(resizeTo size: CGSize?) {
        print("getting")
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
                fetchOptions.fetchLimit = 1 // This is available in iOS 9.
        
        if let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions) as PHFetchResult<PHAsset>?{
            if let asset = fetchResult.firstObject as? PHAsset {
                let manager = PHImageManager.default()
                
                // If you already know how you want to resize,
                // great, otherwise, use full-size.
                let targetSize = size == nil ? CGSize(width: asset.pixelWidth, height: asset.pixelHeight) : size!
                
                // I arbitrarily chose AspectFit here. AspectFill is
                // also available.
                manager.requestImage(for: asset,
                                             targetSize: targetSize,
                                             contentMode: .aspectFit,
                                             options: nil,
                                             resultHandler: { image, info in
                                                
                                                print("got")
                                                
                })
            }
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
        print("here2")
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage//
        print(pickedImage)
        var localUrl = try! saveToDocs(image: pickedImage)//
        analyse(path: localUrl)
        
        picker.dismiss(animated: true, completion: nil)
    
    }

    func analyse(path: URL) {
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        print("path")
        print(path)
        
        let imageSelf = Bundle.main.url(forResource: "download-1", withExtension: "jpg")!//(forResource: path)//Bundle.main.url(forAuxiliaryExecutable: image)
        print(imageSelf);
        
        let failure = { (error: Error) in print(error) }
        let classifierID:[String] = ["Untitled_1208486641"]
        print("starting")
        visualRecognition.classify(imageFile: path, classifierIDs: classifierID , language: "en", failure: failure) { classifiedImages in
            print(classifiedImages)
            if (classifiedImages.images.count > 0){
                print(classifiedImages.images)
                print("classification")
                if(classifiedImages.images[0].classifiers.count > 0){ var classification = classifiedImages.images[0].classifiers[0].classes[0].classification
                    if(classification == "Negative"){
                        self.performSegue(withIdentifier: "healthyResults", sender: self)
                    }
                }
            }
            if let dictionary = classifiedImages as? [String: Any] {
                print(dictionary)
                if let classes = dictionary["classification"] as? String {
                    print(classes)
                    // access individual value in dictionary
                }
            }
            print("Classification")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultsView {
            vc.result = "Healthy"
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
