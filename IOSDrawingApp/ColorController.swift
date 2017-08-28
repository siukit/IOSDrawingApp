//
//  ColorController.swift
//  IOSDrawingApp
//
//  Created by TSZ KIT IEONG on 28/12/2016.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

protocol ColorControllerDelegate: class {
    func colorControllerFinished(colorController: ColorController)
}

//declare color values
var red:CGFloat = 0.0
var green:CGFloat = 0.0
var blue:CGFloat = 0.0
//set draw shape mode as false by default
var squareMode:Float = 0
var circleMode:Float = 0
var shapeSize:CGFloat = 0.0

class ColorController: UIViewController {
    
    
    //outlets for color sliders, size slider and size text field
    @IBOutlet weak var redBar: UISlider!
    @IBOutlet weak var greenBar: UISlider!
    @IBOutlet weak var shapeSizeSlider: UISlider!
    @IBOutlet weak var blueBar: UISlider!
    @IBOutlet weak var setSize: UITextField!
    weak var delegate: ColorControllerDelegate?
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set color sliders value as the chosen color value (or default)
        redBar.value = Float(red)
        greenBar.value = Float(green)
        blueBar.value = Float(blue)
        
        //set max/min values for size slider (for drawing circle and square)
        shapeSizeSlider.maximumValue = 300
        shapeSizeSlider.minimumValue = 10
        shapeSizeSlider.value = Float(shapeSize);
    }
    
    
    @IBAction func shapeSizeAct(sender: AnyObject) {
        //set the circle/square's drawing sizes as the size slider value
        shapeSize = CGFloat(shapeSizeSlider.value)
        
    }
    
    @IBAction func redColor(sender: AnyObject) {
        //set the red color value as the red slider value
        red = CGFloat(redBar.value)

    }
    
    @IBAction func greenColor(sender: AnyObject) {
        
        green = CGFloat(greenBar.value)
    }
    
    @IBAction func blueColor(sender: AnyObject) {
        
        
        blue = CGFloat(blueBar.value)
    }
    
    
    @IBAction func colorChanged(sender: UISlider) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    @IBAction func drawSquare(sender: AnyObject) {
        
        squareMode = 1;
        circleMode = 0;

    }
    
    @IBAction func drawCircle(sender: AnyObject) {
        circleMode = 1;
        squareMode = 0;
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
