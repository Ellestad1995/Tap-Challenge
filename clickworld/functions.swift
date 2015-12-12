//
//  functions.swift
//  Click World
//
//  Created by Joakim Nereng Ellestad on 24.04.15.
//  Copyright (c) 2015 Joakim Nereng Ellestad. All rights reserved.
//

import Foundation
import UIKit




//Finds out what highscore you need to beat to go on.
func getHighscoreFromArray() -> Int{
    var whatHighscore:Int?
    
    if(daysPlayed <= 4 && daysPlayed >= 0)
    {
        whatHighscore = casualScores[Int((daysPlayed))]
    }
    else if(daysPlayed <= 16 && daysPlayed >= 5)
    {
        whatHighscore = coreScore[Int((daysPlayed) - 5)]
    }
    else if(daysPlayed <= 41 && daysPlayed >= 17)
    {
        whatHighscore = hardcoreScore[Int((daysPlayed) - 17)]
    }
    else if(daysPlayed <= 77 && daysPlayed >= 42)
    {
        whatHighscore = proScore[Int((daysPlayed) - 42)]
    }
    else if(daysPlayed <= 127 && daysPlayed >= 78)
    {
        whatHighscore = beastScore[Int((daysPlayed) - 78 )]
    }
    else if(daysPlayed >= 128)
    {
        whatHighscore = leetScore[Int((daysPlayed) - 128)]
    }
    else
    {
        whatHighscore = 0
    }
    
    highScore = Double(whatHighscore!)
    clickDefaults.setObject(highScore, forKey: "\(valueLastHighscore)")
    println("Highscore er: \(highScore)")
    return whatHighscore!
}

//Function to check if you have beat your highscore
//Needs to run on every tap on button click
func didYouBeatHighscore() -> Bool
{
    if(clicks == highScore)
    {
        //This means that the highscore is beat and this needs to be done:
            //Save daysPlayed +1
        
        daysPlayed = Double(clickDefaults.valueForKey(valueDaysPlayed) as! NSNumber) + 1
        //var daysPlayedTest = Double(clickDefaults.valueForKey(valueDaysPlayed) as! NSNumber) + 1
        println("Antall ganger spillt: \(daysPlayed)")
        println("Gratulerer!")
        clickDefaults.setObject(daysPlayed, forKey: valueDaysPlayed)
        
       
        
        return true
    }
    else
    {
        return false
    }
}

//Function for finding correct badge
func findBadge()/*->UIImage*/{
    var imagename: String?
    var number = daysPlayed
    
    if(number <= 4){
        imagename = "noob"
        nextBadge = "casual"
    }
    else if(number <= 16 && number >= 5){
        imagename = "casual"
        nextBadge = "core"
    }
    else if(number <= 41 && number >= 17){
        imagename = "core"
        nextBadge = "hardcore"
    }
    else if(number <= 76 && number >= 42){
        imagename = "hardcore"
        nextBadge = "pro"
    }
    else if(number <= 126 && number >= 77){
        imagename = "pro"
        nextBadge = "beast"
    }
    else if(number <= 186 && number >= 127){
        imagename = "beast"
        nextBadge = "1337"
    }
    else if(number >= 187){
        imagename = "1337"
        nextBadge = "legend"
    }
    
    //var badge = UIImage(named: imagename!)
    currentBadge = imagename!
    //return badge!
    
}

func getArrayLength(){
    println("getArrayLength")
    if(daysPlayed <= 4 && daysPlayed >= 0) //Casual
    {
        barLengthValue = Int(daysPlayed)
        arrayLength = 5
    }
    else if(daysPlayed <= 17 && daysPlayed >= 5) //Core
    {
        barLengthValue = Int(daysPlayed - 5)
        arrayLength = 12
    }
    else if(daysPlayed <= 43 && daysPlayed >= 18)//Hardcore
    {
        barLengthValue = Int(daysPlayed - 12)
        arrayLength = 26
    }
    else if(daysPlayed <= 79 && daysPlayed >= 44) //pro
    {
        barLengthValue = Int(daysPlayed - 26)
        arrayLength = 36
    }
    else if(daysPlayed <= 129 && daysPlayed >= 80)//Beast
    {
        barLengthValue = Int(daysPlayed - 36)
        arrayLength = 50
    }
    else if(daysPlayed >= 130) //1337
    {
        barLengthValue = Int(daysPlayed - 50)
        arrayLength = 60
    }
    else
    {
        arrayLength = 0
        barLengthValue = 0
    }
    
    println("Array lengde er: \(arrayLength). Og ferdigspilt er \(barLengthValue)")
}


func barProgressFunction()
{
    getArrayLength()
  
    var barLength: Double = 1/Double(arrayLength!) //0.2 for 5 length
    var barProgress: Double = Double(barLengthValue) //Ex.: 5
    progress = Float(barLength * barProgress) // 5*0.2= 1
    
}








