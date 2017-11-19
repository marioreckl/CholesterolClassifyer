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
    @IBOutlet var ageLabel: UILabel!
    //@IBOutlet var SwitchForHighCholesterol: UISwitch!
    //@IBOutlet var SwitchForHighBP: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        ageLabel.text = "18"
        //SwitchForHighBP.addTarget(self, action: "switchIsChanged:", for: UIControlEvents.valueChanged)
        //SwitchForHighCholesterol.addTarget(self, action: "switchIsChanged:", for: UIControlEvents.valueChanged)
    }
    func switchIsChanged(mySwitch: UISwitch) {
       
    }

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

    @IBAction func valueChanged( sender: AnyObject) {
        //var currentValue = Int(sender.value)
        
        //ageLabel.text = "\(currentValue)"
    }
    func getHealthMessage() -> String{
        
        if(AgeSlider.value > 50){
            return "Nothing our of the ordinary for your age group could be identified, but you should talk to your docotor about high cholesterol"
        }//else if(SwitchForHighCholesterol.isOn || SwitchForHighBP.isOn){
            //return "Not further information could be determined from your history"
        //}

        return "Elevated levels of cholesterol detected, please talk to your doctor about high cholesterol"
    }
}
