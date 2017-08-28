//
//  ViewController.swift
//  IOSDrawingApp
//
//  Created by TSZ KIT IEONG on 23/12/2016.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{


    var image : CGImageRef?
    var context : CGContextRef?
    
    @IBOutlet weak var drawSize: UISlider!
    //var mySetting:ColorSetting? = nil
    
    @IBOutlet weak var colorValue: UITextField!

    var lastPoint = CGPoint.zero
    var swiped = false

    var drawingSize:CGFloat = 5
    var isDrawing = true
   
//    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var drawingView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mySetting = ColorSetting()
        
        // Do any additional setup after loading the view, typically from a nib.
//        drawSize.isHidden = true
        drawSize.maximumValue = 50
        drawSize.minimumValue = 1
        drawSize.value = 10

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
//        let context = UIGraphicsGetCurrentContext()
        if let touch = touches.first {
            lastPoint = touch.locationInView(self.view)
        }
        
        
//        let w = UIScreen.mainScreen().bounds.width
//        let h = UIScreen.mainScreen().bounds.height
//        
//        if (image == nil)
//        {
//            let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()!
//            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
//            context = CGBitmapContextCreate(nil, Int (w*2), Int (h*2), 8, Int (w*4*2), colorSpace, bitmapInfo.rawValue)
//        }
        CGContextSetLineWidth(context, 2.0)
        image = CGBitmapContextCreateImage(context);
        
    }
    
    func drawLine(fromPoint:CGPoint,toPoint:CGPoint) {
//        colorValue.text = String(red)
        UIGraphicsBeginImageContext(self.view.frame.size)
        drawingView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let context = UIGraphicsGetCurrentContext()
        
        if(squareMode == 0){
            CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
            CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
            CGContextSetLineCap(context, CGLineCap.Round)
            drawingSize = CGFloat(drawSize.value)
            if(circleMode == 1){
                drawingSize = shapeSize
            }
            CGContextSetLineWidth(context, drawingSize)
        
            CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
            CGContextStrokePath(context)
        }
        
        
        if(squareMode == 1) {
            CGContextSetLineWidth(context, 2.0)
            let rectangle = CGRect (x: lastPoint.x-shapeSize/2, y: lastPoint.y-shapeSize/2, width: shapeSize, height: shapeSize)
            
            
            CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
            CGContextAddRect (context,  rectangle)
            CGContextFillPath (context)
            CGContextSetLineWidth(context, 100)
        }
        
        if(circleMode == 1) {
            
            CGContextSetLineWidth(context, 100)
            
        }
        
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image = CGBitmapContextCreateImage(context);

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.locationInView(self.view)
            if(circleMode == 0 && squareMode == 0){
                drawLine(lastPoint, toPoint: currentPoint)
            }
            
//            if(squareMode == 0){
//                drawLine(lastPoint, toPoint: currentPoint)
//            }

            lastPoint = currentPoint
//            let rectangle = CGRect (x: currentPoint.x, y: currentPoint.y, width: 10, height: 10)
//            let context = UIGraphicsGetCurrentContext()
            //context?.addRect (rectangle)
        }
        let context = UIGraphicsGetCurrentContext()
        image = CGBitmapContextCreateImage(context);
//        
//        let w = UIScreen.mainScreen().bounds.width
//        let h = UIScreen.mainScreen().bounds.height
//        
//        if (image == nil)
//        {
//            let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()!
//            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
//            context = CGBitmapContextCreate(nil, Int (w*2), Int (h*2), 8, Int (w*4*2), colorSpace, bitmapInfo.rawValue)
//        }

        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !swiped {
            drawLine(lastPoint, toPoint: lastPoint)
        }
    }
    

    @IBAction func reset(sender: AnyObject) {
         self.drawingView.image = nil
    }
    
    
    @IBAction func setSize(sender: AnyObject) {
        
        squareMode = 0
        circleMode = 0
        if (red,green,blue) == (1,1,1){
            (red,green,blue) = (0,0,0)
        }

        
    }
    
    @IBAction func setColor(sender: AnyObject) {
    }
    
    
    @IBAction func save(sender: AnyObject) {
        
        

        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: { imageP in })
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
                    //drawingView.contentMode = .scaleAspectFit
                    drawingView.image = pickedImage
                    //drawingView.setNeedsDisplay()
                    drawingView.setNeedsDisplay()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    @IBAction func erasee(sender: AnyObject) {
//        drawSize.isHidden = false
        (red,green,blue) = (1,1,1)
        
    }
    
    
}



//@IBAction func save(sender: AnyObject) {
//    //        UIGraphicsBeginImageContext(self.view.frame.size)
//    //        drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//    //        let image = UIGraphicsGetImageFromCurrentImageContext()
//    //        UIGraphicsEndImageContext()
//    //
//    //        let image = drawingView.image
//    //        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
//    //        self.presentViewController(activity, animated: true, completion: nil)
//    
//    
//    //        if let image = drawingView.image {
//    //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//    //        }
//    //        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//    //
//    //            imagePicker.sourceType = .savedPhotosAlbum
//    //            imagePicker.allowsEditing = false
//    //
//    //            self.present(imagePicker, animated: true, completion: nil)
//    //        }
//    
//    let picker : UIImagePickerController = UIImagePickerController()
//    picker.delegate = self
//    picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
//    picker.allowsEditing = true
//    self.presentViewController(picker, animated: true, completion: { imageP in })
//    
//}

//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//
//            //drawingView.contentMode = .scaleAspectFit
//            drawingView.image = pickedImage
//            //drawingView.setNeedsDisplay()
//
//            //let context = UIGraphicsGetCurrentContext()
//            //let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
//
//
//            // draw image in context
//            //context?.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
////            drawingView.setNeedsDisplay()
//            //CGContextDrawImage(context, imageRect, image.cgImage)
//
//        }
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }



