//
//  ViewController.swift
//  Cholestroll
//
//  Created by Nafeh Shoaib on 2017-11-17.
//  Copyright © 2017 nafehshoaib. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 11.0, *)
class ViewController: UIViewController {
    
    @IBOutlet var capturePreviewView: UIView!
    
    let cameraController = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        
        configureCameraController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        
    }
    
}
