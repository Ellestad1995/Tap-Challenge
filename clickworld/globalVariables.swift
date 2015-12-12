//
//  globalVariables.swift
//  Click World
//
//  Created by Joakim Nereng Ellestad on 23.04.15.
//  Copyright (c) 2015 Joakim Nereng Ellestad. All rights reserved.
//

import Foundation
import UIKit

//NSUserDefaults
let clickDefaults = NSUserDefaults.standardUserDefaults()
let valueForKeyClick = "clicksNumber"
let valueDaysPlayed = "daysPlayed"
let valueTimeStamp = "timeStamp"
let valueLastHighscore = "LastHighscore"
//global variables
var clicks: Double = 0 //Number of clicks, recieved from viewController, store in coreData when application closes.
var clicksString: String = String(format: "%.f", clicks)
var highScore: Double = 0 //Recieve from from array when getHighScoreFromArray() is run! Done!
var currentBadge: String = ""//Is retrieved from findBadge()
var daysPlayed:Double = 0  //Are stored in NSUserDefaults. Days succesfully played. Done!
var nextBadge: String = ""

var timeStampSinceLastPlayed:Int = 0
var daysSinceTheStart: Int = 0 //Time right now since 1. january 1970
//Progressbar

var progress : Float = 0

//Array length values
var arrayLength: Int?
var barLengthValue: Int = 0

//animation
var createLayer = false

//Array of highscores
var casualScores = [49, 59, 69, 99, 100]//#5

var coreScore = [109, 119, 130, 131, 133, 139, 149, 159, 169, 179, 189, 200] //12

var hardcoreScore = [201, 209, 210, 211, 222, 229, 239, 244, 254, 256, 259, 269, 270, 279, 288, 295, 299, 300, 301, 310, 320, 333, 336, 366, 399]//#25

var proScore = [400, 401, 409, 419, 429, 433, 444, 458, 469, 470, 489, 500, 509, 519, 529, 533, 539, 544, 550, 555, 569, 576, 580, 600, 602, 623, 632, 666, 669, 680, 699, 700, 701, 722, 733]//#35

var beastScore = [750, 777, 799, 800, 801, 824, 832, 842, 844, 855, 888, 899, 900, 901, 930, 955, 969, 999, 1000, 1001, 1009, 1022, 1040, 1069, 1080, 1099, 1100, 1101, 1111, 1122, 1133, 1144, 1155, 1166, 1177, 1188, 1199, 1200, 1201, 1222, 1227, 1239, 1250, 1269, 1279, 1299, 1300, 1301, 1311, 1333] //#50

var leetScore = [1337, 1344, 1366, 1378, 2000, 2500, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 10000, 10001, 10010, 10101, 11001, 11100, 11111, 12000, 13337, 15000, 16000, 17000, 18000, 19000, 19999, 20000, 20100, 20500, 21000, 21500, 22222, 23000, 23333, 24000, 24444, 25000, 26000, 26666, 26669, 27000, 27009, 27777, 28000, 28880, 30000, 3033, 31111, 33333, 33404, 35000, 36000, 37000, 40000, 44444, 40669, 50000] //#60

//Number of days you´ll need full score
let badges: Dictionary = ["noob":0, "casual":5 , "core":12, "hardcore":26, "pro":36,"beast":50, "1337":60]
