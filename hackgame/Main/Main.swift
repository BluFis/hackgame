
import UIKit


class Main: UIViewController,UITextFieldDelegate {
    
    
    //MARK - varibles
    
    var data =  NSDictionary(contentsOfFile: NSHomeDirectory() + "/Documents/Results.plist")
    var elemets = ["time":"00:00","repeat":0,"score":0,"get":false] as [String : Any]
    var nextLabelRect = CGRect()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var textLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Last login：Wed \(getProfile()[5] as! NSData) on console"
        headLabel.text = "Device:~\(getProfile()[1] as! NSData)$"
        nextLabelRect = CGRect(x: headLabel.frame.origin.x, y: headLabel.frame.maxY, width: headLabel.frame.width + textLabel.frame.width, height: headLabel.frame.height)
        textLabel.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let resultLabel = UILabel(frame: nextLabelRect)
        resultLabel.text = self.textLabel.callback(Str: self.textLabel.text!, result: getProfile())
        resultLabel.textColor = UIColor.white
        let nextHeadLabel = UILabel(frame: CGRect(origin: CGPoint(x:resultLabel.frame.origin.x,y:resultLabel.frame.maxY), size: self.headLabel.frame.size))
        nextHeadLabel.textColor = UIColor.white
        nextHeadLabel.text = headLabel.text
        let nextTextLabel = UITextField(frame: CGRect(origin: CGPoint(x:resultLabel.frame.origin.x + resultLabel.frame.width,y:resultLabel.frame.maxY), size: self.textLabel.frame.size))
        nextTextLabel.textColor = UIColor.white
        nextLabelRect = CGRect(origin: CGPoint(x:nextHeadLabel.frame.origin.x,y:nextHeadLabel.frame.maxY), size: nextLabelRect.size)
        self.view.addSubview(resultLabel)
        self.view.addSubview(nextHeadLabel)
        self.view.addSubview(nextTextLabel)
        
    }
    
    
    
    func getProfile()->Array<Any>{
        let profile = NSDictionary(contentsOfFile: NSHomeDirectory() + "/Documents/Account.plist")
        print(profile!)
        let file = profile![0] as! NSDictionary
        return [file["username"] as! String,file["level"] as! Int,file["time"] as! String,file["repeat"] as! Int, file["score"] as! Int,file["lastlogin"] as! NSData]
    }

    func prepareForGame(){
        var diction = [[elemets]]
        if let dataCheck = data?[0] as? NSDictionary{
            if let checkFirst = dataCheck["get"] as? Bool{
                if checkFirst{
                    
                    for dic in 0...data!.count{
                        let Data = data![dic]! as! NSDictionary
                        elemets["time"] = Data["time"]
                        elemets["repeat"] = Data["repeat"]
                        elemets["score"] = Data["score"]
                        elemets["get"] = Data["get"]
                        diction.append([elemets])
                    }
                    
                }
            }
      
        }else{
            NSArray(array: diction).write(toFile: NSHomeDirectory() + "/Documents/Results.plist", atomically: true)
        }
        
    }
}
