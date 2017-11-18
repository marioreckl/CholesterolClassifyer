//
//  QuestionsView.swift
//  CholesterolClassifyer
//
//  Created by Mario Reckl on 2017-11-18.
//  Copyright © 2017 Mario Reckl. All rights reserved.
//

import Foundation
import UIKit

class QuestionsView: UIViewController {
    @IBOutlet var AgeSlider: UISlider!
    @IBOutlet var SwitchForHighCholesterol: UISwitch!
    @IBOutlet var SwitchForHighBP: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
