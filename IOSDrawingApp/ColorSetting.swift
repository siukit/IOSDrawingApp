//
//  ColorSetting.swift
//  IOSDrawingApp
//
//  Created by TSZ KIT IEONG on 27/12/2016.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class ColorSetting: UIViewController {

    @IBOutlet weak var redBar: UISlider!
    
    @IBOutlet weak var greenBar: UISlider!
    
    @IBOutlet weak var blueBar: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
