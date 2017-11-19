//
//  ResultsView.swift
//  CholesterolClassifyer
//
//  Created by Mario Reckl on 2017-11-18.
//  Copyright © 2017 Mario Reckl. All rights reserved.
//

import Foundation
import UIKit

class ResultsView: UIViewController {
    var result: String!
    @IBOutlet var resultsLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("results")
        resultsLabel.text = result
    }
    /*func viewWillAppear(){
        print("results")
        resultsLabel.text = result
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
