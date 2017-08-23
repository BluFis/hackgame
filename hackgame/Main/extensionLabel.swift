import UIKit

extension UITextField{

    func callback(Str:String,result:Array<Any>)->String{
        
        switch Str {
        case "help":
            return "account  display your profile.\("/n")start  start game.\("/n")rank  display all rank.\("/n")about  about this game"
        case "account":
            return "name:\(result[0] as! String),level:\(result[1] as! Int),timeCost:\(result[2] as! String),tryTimes:\(result[3] as! Int),score:\(result[4]as! Int)"
        case "start":
            return "prepare to start...."
        case "rank":
            return "downloading rank"
        case "":
            return ""
        case "about":
            return "Developed by NewGenius 2017®"
        default:
            return "no such command"
        }

    }
    
}
