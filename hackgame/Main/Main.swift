
import UIKit


class Main: UIViewController,UITextFieldDelegate {
    
    
    //MARK - varibles
    
   
    @IBOutlet weak var StackView: UIStackView!
    var elemets = ["time":"00:00","repeat":0,"score":0,"get":false] as [String : Any]
    var nextLabelRect = CGRect()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var textLabel: UITextField!

    var textBtns = Array<UITextField>()
    var resultLabels = Array<UILabel>()
    var headLabels = Array<UILabel>()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
        prepareForGame()
        titleLabel.text = "Last login：Wed \(getProfile()[5] as! String) on console"
        headLabel.text = "Device:~\(getProfile()[0] as! String)$"
        
        nextLabelRect = CGRect(x: StackView.frame.origin.x, y: StackView.frame.maxY, width: StackView.frame.width, height: StackView.frame.height)
        textBtns.append(textLabel)
        textLabel.delegate = self
        

        // Do any additional setup after loading the view.
    }
    func directoryURL(Str:String) -> URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let URL = documentDirectory.appendingPathComponent(Str)
        print(URL)
        return URL
    }
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
}


    func textFieldDidEndEditing(_ textField: UITextField) {
        print("endediting")
        let resultLabel = UILabel(frame: nextLabelRect)
        resultLabel.text = self.textBtns.last?.callback(Str: (self.textBtns.last?.text!)!, result: getProfile())
        switch resultLabel.text! {
        case "start":
            print("start")
        case "rank":
            print("rank")
        case "":
            print("nil")
        case "clearing":
            resultLabel.frame = StackView.frame
            for items in headLabels{
                 items.removeFromSuperview()
              }
            for items in textBtns{
                  items.removeFromSuperview()
              }
            for items in resultLabels{
                  items.removeFromSuperview()
              }
        default:
            print("ok")
        }
        resultLabel.textColor = UIColor.white
        resultLabel.font = UIFont(name: "Menlo", size: 11)
        let nextHeadLabel = UILabel(frame: CGRect(origin: CGPoint(x:resultLabel.frame.origin.x,y:resultLabel.frame.maxY), size: self.headLabel.frame.size))
        nextHeadLabel.textColor = UIColor.white
        nextHeadLabel.font = UIFont(name: "Menlo", size: 11)
        nextHeadLabel.text = headLabel.text
        let nextTextLabel = UITextField(frame: CGRect(origin: CGPoint(x:nextHeadLabel.frame.maxX,y:resultLabel.frame.maxY), size: self.textLabel.frame.size))
        nextTextLabel.textColor = UIColor.white
        nextTextLabel.font = UIFont(name: "Menlo", size: 11)
        nextLabelRect = CGRect(origin: CGPoint(x:nextHeadLabel.frame.origin.x,y:nextHeadLabel.frame.maxY), size: nextLabelRect.size)
        textBtns.last?.isUserInteractionEnabled = false
        print(nextTextLabel.frame)
        print(nextHeadLabel.frame)
        nextTextLabel.delegate = self
        textBtns.append(nextTextLabel)
        headLabels.append(nextHeadLabel)
        resultLabels.append(resultLabel)
        self.view.addSubview(resultLabel)
        self.view.addSubview(nextHeadLabel)
        self.view.addSubview(nextTextLabel)
        
    }
    
    func getProfile()->Array<Any>{
        let profile = NSDictionary(contentsOf: directoryURL(Str: "Account.plist")!)
        if profile != nil{
            return [profile!["username"] as! String,profile!["level"] as! Int,profile!["time"] as! String,profile!["repeat"] as! Int, profile!["score"] as! Int,profile!["lastlogin"] as! NSData]
        }else{//获取当前时间
            let now = Date()
            
            // 创建一个日期格式器
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            let initDiction = ["username":"user","level":0,"time":"00:00","repeat":0,"score":0,"lastlogin":dformatter.string(from: now) , "password":"000000","emailadress":"123@gmail.com","rank":0] as [String : Any]
            NSDictionary(dictionary: initDiction).write(toFile:"\(String(describing:directoryURL(Str: "Account.plist")))", atomically: true)
      
            return ["user",0,"00:00",0,0,dformatter.string(from: now)]
        }
    }

    func prepareForGame(){
        var diction = [[elemets]]
        let data =  NSDictionary(contentsOf: directoryURL(Str: "Results.plist")!)
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
            NSArray(array: diction).write(toFile:"\(String(describing:directoryURL(Str: "Results.plist")))", atomically: true)
        }
        
    }
}
