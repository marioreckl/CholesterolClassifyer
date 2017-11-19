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
     if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
     let imagePicker = UIImagePickerController()
     imagePicker.delegate = self
     imagePicker.sourceType = UIImagePickerControllerSourceType.camera
     imagePicker.allowsEditing = false
     self.present(imagePicker, animated: true, completion: nil)
     }
    }
    func saveImage(image: UIImage) -> () {
       print("save")
       UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
    }
    
    func queryLastPhoto(resizeTo size: CGSize?, queryCallback: @escaping ((UIImage?) -> Void)) {
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
                                                
                                                queryCallback(image)
                })
            }
        }
    }
    /*@objc private func image(path: String, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer?) {
        
        print("path")
        analyse(path: path)
         // That's the path you want
    }
    

    func fetchPhotos () {
        var image = NSMutableArray()
        totalImageCountNeeded = 1
        self.fetchPhotoAtIndexFromEnd(0)
    }
    func fetchPhotoAtIndexFromEnd(index:Int) {
        
        let imgManager = PHImageManager.defaultManager()
        
        // Note that if the request is not set to synchronous
        // the requestImageForAsset will return both the image
        // and thumbnail; by setting synchronous to true it
        // will return just the thumbnail
        var requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        
        // Sort the images by creation date
        var fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                imgManager.requestImageForAsset(fetchResult.objectAtIndex(fetchResult.count - 1 - index) as PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, _) in
                    
                    // Add the returned image to your array
                    self.images.addObject(image)
                    
                    // If you haven't already reached the first
                    // index of the fetch result and if you haven't
                    // already stored all of the images you need,
                    // perform the fetch request again with an
                    // incremented index
                    if index + 1 < fetchResult.count && self.images.count < self.totalImageCountNeeded {
                        self.fetchPhotoAtIndexFromEnd(index + 1)
                    } else {
                        // Else you have completed creating your array
                        println("Completed array: \(self.images)")
                    }
                })
            }
        }
    */
   /* func onYesClicked(image:UIImage){
        // i'm using optional image here just for example
        
            UIImageWriteToSavedPhotosAlbum(
                image, self,
                Selector("image:didFinishSavingWithError:contextInfo:"),
                nil)
        }\
    }*/
    
    func image(
        image: UIImage!,
        didFinishSavingWithError error:NSError!,
        contextInfo:UnsafePointer<Void>)
    {
        print("ggod")
        // process success/failure here
    }
    func image(
        path: String,
        didFinishSavingWithError error:NSError!,
        contextInfo:UnsafePointer<Void>)
    {
        print("testing")
        analyse(path: path)
        // process success/failure here
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
        print(pickedImage)
        saveImage(image: pickedImage)
        /*let imageName = imageURL.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as! String
        let localPath = documentDirectory.stringByAppendingPathComponent(imageName)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImagePNGRepresentation(image)
        data.writeToFile(localPath, atomically: true)
        
        let imageData = NSData(contentsOfFile: localPath)!
        let photoURL = URL(fileURLWithPath: localPath)
        let imageWithData = UIImage(data: imageData)!*/
        //var path = try! saveToDocs(image: pickedImage)
       // analyse(path: imageURL)
      
        
        picker.dismiss(animated: true, completion: nil)
    }

    func analyse(path: String) {
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        print("in")
        
        let imageSelf = Bundle.main.url(forResource: path, withExtension: "jpg")!//(forResource: path)//Bundle.main.url(forAuxiliaryExecutable: image)
        //print(imageSelf);
        
//        let jsonObject = {
//            "images": image
//        }

        let failure = { (error: Error) in print(error) }
        let classifierID:[String] = ["Untitled_683728389"]
        print("starting")
        visualRecognition.classify(imageFile: imageSelf, classifierIDs: classifierID , language: "en", failure: failure) { classifiedImages in
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
