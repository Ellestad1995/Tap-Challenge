//  ViewController.swift
//  clickworld
//
//  Created by Joakim Nereng Ellestad on 19.05.15.
//  Copyright (c) 2015 Joakim Nereng Ellestad. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
    
    
    @IBOutlet var myViewController: UIView!
    
    //image
    @IBOutlet weak var imageContainer01: UIImageView!
    
    @IBOutlet weak var imageContainer02: UIImageView!
    //image
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    @IBOutlet weak var buttonClick: UIButton!
    
    @IBOutlet weak var labelBadge: UILabel!
    
    @IBOutlet weak var labelHighscore: UILabel!
    
    @IBOutlet weak var imageClick: UIImageView!
    
    @IBOutlet weak var finishText: UILabel!
    
    @IBOutlet weak var labelClick: UILabel!
    
    
    @IBOutlet weak var iAdBannerView: ADBannerView!
    
    let layerView = UIView() //layer for animation
    
    
    
    @IBOutlet weak var developer_mode: UISwitch!
    
    
    
    
    func setImage()
    {
        imageContainer02.image = UIImage(named: "\(currentBadge).png")
        imageContainer01.image = UIImage(named: "\(nextBadge).png")
        imageContainer01.alpha = CGFloat(progress + 0.1)
        let layer = CALayer()
        let value: Double = Double(60 * progress)
        let positionValue: Double = Double(30 * progress)
        layer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        layer.contents = UIImage(named: "black.png")?.CGImage
        imageContainer01.layer.addSublayer(layer)
    }


    
    func tapGestureButton()
    {
        if developer_mode.on{
            //I want to just set clicks to 100%
            clicks = highScore
            clickDefaults.setObject(clicks, forKey: valueForKeyClick)
            labelClick.text = toString(Int(clicks))
            println(clicks)
            /*
            UIView.animateWithDuration(0.5, animations: {
            self.imageClick.transform = CGAffineTransformMakeRotation((90 * CGFloat(M_PI)) / 180)
            })*/
            rotateImage()
            if didYouBeatHighscore(){
                imageClick.hidden = true
                finishText.hidden = false
                
                var barLength: Double = 1/Double(arrayLength!)
                if((barLengthValue * Int(barLength)) == 1 ){
                    println("Animating is true")
                    animationCreateLayer()
                }
                getArrayLength()
                barProgressFunction()
                println("FREMGANG: \(progress)")
                progressbar.setProgress(progress, animated: true)
                findBadge()
                setImage()
                
            }

        }
        else
        {
            clicks++
            clickDefaults.setObject(clicks, forKey: valueForKeyClick)
            labelClick.text = toString(Int(clicks))
            println(clicks)
            /*
            UIView.animateWithDuration(0.5, animations: {
            self.imageClick.transform = CGAffineTransformMakeRotation((90 * CGFloat(M_PI)) / 180)
            })*/
            rotateImage()
            if didYouBeatHighscore()
            {
                imageClick.hidden = true
                finishText.hidden = false
            
                var barLength: Double = 1/Double(arrayLength!)
                if((daysPlayed * barLength) == 1 )
                {
                println("Animating is true")
                animationCreateLayer()
                }
                getArrayLength()
                barProgressFunction()
                println("FREMGANG: \(progress)")
                progressbar.setProgress(progress, animated: true)
                findBadge()
                setImage()
            
            }
        }
    }
    var tempClicks: Double = 0
    var rotateNumber: Double = 1
    
    func rotateImage()
    {
        tempClicks+=1
        rotateNumber = 10 * tempClicks
        println("\(tempClicks) and \(rotateNumber)")
        var radians: CGFloat = CGFloat((M_PI/180) * rotateNumber)
        
        UIView .animateWithDuration(NSTimeInterval(0.05), animations: { () -> Void in
            self.imageClick.transform = CGAffineTransformMakeRotation(radians)
    
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Viewdid load runs!")
        //iAd banner view
        self.canDisplayBannerAds = true
        self.iAdBannerView?.delegate = self
        self.iAdBannerView.hidden = true
        
        var played: Bool = clickDefaults.boolForKey("played")
        finishText.hidden = true
        if !played
        {
            println("Første gangen ja!")
            clickDefaults.setObject(0, forKey: valueDaysPlayed)
            clickDefaults.setObject(0, forKey: valueForKeyClick)
            clickDefaults.setObject(0, forKey: valueTimeStamp)
            clickDefaults.setObject(0, forKey: valueLastHighscore)
            clickDefaults.setBool(true, forKey: "played")
        }
        else
        //It´s not the first day, continue playing
        {
            //Doesn´t matter. Go on because i can now unwrappe values
        }
            if checkTimestamp() //returnerer true, betyr at det er en ny dag!
            {
                //Hvis ny dag:
                labelClick.text = toString(Int(clicks))
                
            }
            else //Hvis det er samme dag!
            {
                if(clicks == highScore)
                {
                    imageClick.hidden = true
                    println("Du har allerede slått dagens highscore")
                    finishText.hidden = false
                }
                else
                {
                    println("Fortsett å trykke, du har \(clicks) klikk")
                    labelClick.text = toString(Int(clicks))
                }
                
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("tapGestureButton"))
            imageClick.addGestureRecognizer(tapGesture)
            imageClick.userInteractionEnabled = true
            
            
            println("Antall klikk: \(clickDefaults.valueForKeyPath(valueForKeyClick))")
            println("Ganger spillt: \(clickDefaults.valueForKeyPath(valueDaysPlayed))")

            findBadge()
            labelHighscore.text = toString(Int(highScore))
            labelBadge.text = currentBadge
            setImage()
            //Make progressBar
            getArrayLength()
            barProgressFunction()
            progressbar.setProgress(progress, animated: true)
            println("Progressbar progress:\(progress)")
        
        
        
        
        
        
        }//End of viewdidload
    
    var gestureRecognizerHolder: UITapGestureRecognizer = UITapGestureRecognizer() ;
    
    
    func animationCreateLayer()
    {
        
        //Creates animation
        println("animationcreatelayer")
        /*
        let layerRemove = UITapGestureRecognizer(target: self, action: Selector("removeLayer"))
        view.addGestureRecognizer(layerRemove)
        view.userInteractionEnabled = true //Fikse the view
        
        gestureRecognizerHolder = layerRemove
        */
        /*
        //Adding the blur on the background
        var visualBlur = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualBlur.frame = view.bounds
        view.addSubview(visualBlur)
        //The basic layer for new badge
        */
        
        //Let´s hide crap in the background
        labelHighscore.hidden = true
        labelBadge.hidden = true
        
        //let layerView = UIView()
        let layerWidth: Float = 2 //200
        let layerHeight: Float = 2.5//250
        let layerX: Float = ((Float(self.view.frame.width) / Float(2)) - (100))
        let layerY: Float = ((Float(self.view.frame.height)/Float(2)) - (125))
        layerView.frame = CGRect(x: CGFloat(layerX), y: CGFloat(layerY), width: CGFloat(200), height: CGFloat(250))
        
        let background = UIColor.whiteColor()
        let cornerRadius: CGFloat = 15
        let borderColor = UIColor.blackColor().CGColor
        let borderWidth: CGFloat = 5
        layerView.backgroundColor = background
        layerView.autoresizesSubviews = true
        
        view.insertSubview(layerView, atIndex: 1)
        
        
        //Creating imagelayer
        let layerImage = UIImageView()
        let imageWidth: Float = 120 // 120
        let imageHeight: Float = 120 // 120
        let imageX: Float = 40
        let imageY: Float = 10
        layerImage.layer.frame = CGRect(x: CGFloat(imageX), y: CGFloat(imageY), width: CGFloat(imageWidth), height: CGFloat(imageHeight))
        
        let image = UIImage(named: "\(nextBadge).png")
        layerImage.image = image!
        
        
        let imageTotalSize = layerImage.frame.size.height
        println("\(imageTotalSize)")
        
        //Creating the text layer Beast!
        
        let layerText = UILabel()
        let textWidth: CGFloat = CGFloat(200)
        let textHeight: CGFloat = 22
        let textX: CGFloat = 0
        let textY: CGFloat = 130
        layerText.frame = CGRect(x: textX, y: textY, width: textWidth, height: textHeight)
        
        let font: CFStringRef = "HelveticaNeue-Light"
        
        layerText.text = nextBadge
        layerText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        layerText.numberOfLines = 0
        layerText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        layerText.adjustsFontSizeToFitWidth = true
        layerText.textColor = UIColor.blackColor()
        layerText.textAlignment = NSTextAlignment.Center
        
        
        
        
        let layerTextTotalSize = layerText.frame.size.height
        println("\(layerTextTotalSize)")
        //Creating the text layer congratulations
        
        let layerTextFull = UILabel()
        let textFullWidth: CGFloat = CGFloat(200)
        let textFullHeight: CGFloat = 100
        let textFullX: CGFloat = 5
        let textFullY: CGFloat = imageTotalSize + layerTextTotalSize + 20
        layerTextFull.frame =  CGRect(x: textFullX, y: textFullY, width: textFullWidth, height: textFullHeight)
        
        
        layerTextFull.text = String("Congratulations on your new badge! Can you make the next?")
        layerTextFull.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        layerTextFull.numberOfLines = 0
        layerTextFull.lineBreakMode = NSLineBreakMode.ByWordWrapping
        layerTextFull.adjustsFontSizeToFitWidth = true
        layerTextFull.textColor = UIColor.grayColor()
        layerTextFull.textAlignment = NSTextAlignment.Center
        
        
        
        
        let layerTextFullTotalSize = layerTextFull.frame.size.height
        println("\(layerTextFullTotalSize)")
        
        
        
        
        
        
        //view.addSubview(layerView)
        layerView.insertSubview(layerImage, atIndex: 1)
        layerView.insertSubview(layerText, atIndex: 1)
        layerView.insertSubview(layerTextFull, atIndex: 1)
        
        
        
        //Animating
        layerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
        
        let duration: NSTimeInterval = NSTimeInterval(1.5)
        let delay: NSTimeInterval = NSTimeInterval(0) // delay will be 0.0 seconds (e.g. nothing)
        let aOptions = UIViewAnimationOptions.CurveEaseInOut
        
        
        UIView.animateWithDuration(duration, delay: delay,
            options: aOptions, animations: {
                self.layerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
                
            }, completion: nil)
        
    }//animation create layer end
    
    
    func removeLayer()
    {
        println("removeLayer")
        layerView.layer.removeFromSuperlayer()
        
        myViewController.removeGestureRecognizer(gestureRecognizerHolder)
    }

   
    
    
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        //code
        
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.iAdBannerView?.hidden = false
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        //code
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        //code
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        println("Minne advarsel")
    }


}

