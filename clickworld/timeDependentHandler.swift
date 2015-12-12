//
//  timeDependentHandler.swift
//  Click World
//
//  Created by Joakim Nereng Ellestad on 22.04.15.
//  Copyright (c) 2015 Joakim Nereng Ellestad. All rights reserved.
//

import Foundation
import UIKit

//Recieve timestamp from last played from core data and if the time is more than 24 hours then player will loose points.

    

    
func createTimeStamp() -> Int{
    //Creates days since 1970
    let localTimeZone = NSTimeZone.localTimeZone().secondsFromGMT
    let secondsSinceTheStart = NSDate().timeIntervalSince1970
    let time = localTimeZone + Int(secondsSinceTheStart)
    //seconds to days
    let daysSinceTheStart = Int((((time/60)/60)/24)) //save this value to core data when user plays
    clickDefaults.setObject(daysSinceTheStart, forKey: valueTimeStamp)
    println("Tidsstempel: \(daysSinceTheStart)")
    return daysSinceTheStart
}

    //Next time user start game
    // This will set up the game when it starts
    //Check to see if we need to set a new highscore:

func checkTimestamp() -> Bool
{
    var returnVar: Bool?
    var timestamp: Int?

        if  Int(clickDefaults.valueForKey(valueTimeStamp) as! NSNumber) < createTimeStamp()
        {
            //It´s a new day.
            println("We need new highscore, it´s a new day")
            clicks = 0 //Reset clicks
            daysPlayed = Double(clickDefaults.valueForKey(valueDaysPlayed) as! NSNumber)
            //Get the highScore and set it
            getHighscoreFromArray()  //Get current badge and set it to UI
            returnVar = true
            println("Ny dag")
            
        }
        else //Means it´s equal or higher
        {
            //Keep the same timestamp and load the number of clicks the user alredy have done!
            //load clicks and highscore
            clicks = Double(clickDefaults.valueForKey(valueForKeyClick) as! NSNumber)
            println("Du har klikket: \(clicks) fra før")
            daysPlayed = Double(clickDefaults.valueForKey(valueDaysPlayed) as! NSNumber)
            println("Antall dager spilt: \(daysPlayed)")
            highScore = Double(clickDefaults.valueForKey(valueLastHighscore) as! NSNumber)
            println("Highscore er: \(highScore)")
            returnVar = false
            println("Samme dag")
        }
    
    return returnVar!
    
}





