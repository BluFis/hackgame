import UIKit

extension UITextField{

    func callback(Str:String,result:[String:Any])->[String]{
        
        switch Str {
        case "Help":
            return ["Account : display your profile.","Start : start game.","Rank : display all rank.","Clear : refresh screen","Back : back to login","About : about this game"]
        case "Account":
            let level = String(result["level"] as! Int)
            let totalTry = String(result["totalTry"] as! Int)
            let totalScore = String(result["totalScore"]as! Int)
            return ["name:\(result["username"] as! String)","level:\(level)","timeCost:\(result["totalTime"] as! String)","tryTimes:\(totalTry)","score:\(totalScore)"]
        case "Start":
            return ["starting"]
        case "Rank":
            return ["downloading rank"]
        case "About":
            return ["Developed by NewGenius 2017®"]
        case "Clear":
            return ["clearing"]
        case "Back":
            return ["backing"]
        default:
            return ["no such command"]
        }

    }
    
}
