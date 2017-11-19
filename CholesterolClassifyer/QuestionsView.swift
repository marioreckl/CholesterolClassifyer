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
        SwitchForHighBP.addTarget(self, action: "switchIsChanged:", for: UIControlEvents.valueChanged)
        SwitchForHighCholesterol.addTarget(self, action: "switchIsChanged:", for: UIControlEvents.valueChanged)
    }
    func switchIsChanged(mySwitch: UISwitch) {
       
    }
    @IBOutlet var ageLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultsView {
            vc.result = getHealthMessage()
        }
    }
    @IBAction func getResults(_ sender: Any) {
        print(AgeSlider.value)
        //print(SwitchForHighCholesterol.isOn)
        //print(SwitchForHighBP.isOn)
        self.performSegue(withIdentifier: "ShowResults", sender: self)
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        ageLabel.text = "\(currentValue)"
    }
    func getHealthMessage() -> String{
        print("returned not healthy")
        return "Not Healthy"
    }
}
