
import UIKit


class Main: UIViewController,UITextFieldDelegate {
    
    
    //MARK - varibles
    
   
    @IBOutlet weak var helpView: UILabel!
    
   
    @IBOutlet weak var stackView: UIStackView!
    var nextLabelRect = CGRect()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var textLabel: UITextField!

    var textBtns = Array<UITextField>()
    var resultLabels = Array<UILabel>()
    var headLabels = Array<UILabel>()
    let prepare = PrepareForGame()
    override func viewDidLoad() {
        super.viewDidLoad()
        headLabel.boundscolour()
        
        let data = prepare.getProfile()
        print("load")
        titleLabel.text = "Last login：Wed \(data["lastLogin"] as! String) on console"
        headLabel.text = "Device:~\(data["username"] as! String)$"
    
        nextLabelRect = CGRect(x: stackView.layer.frame.origin.x, y: stackView.frame.maxY * 1.1, width: stackView.frame.width, height: stackView.frame.height)
            print(nextLabelRect)
        headLabels.append(headLabel)
        textBtns.append(textLabel)
        textLabel.delegate = self
        

        // Do any additional setup after loading the view.
    }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
}


    func textFieldDidEndEditing(_ textField: UITextField) {
        print("endediting")
        let resultLabel = UILabel()
        resultLabel.textColor = UIColor.white
        resultLabel.font = UIFont(name: "Menlo", size: 11)
        let resultArray = self.textBtns.last?.callback(Str: (self.textBtns.last?.text!)!, result: prepare.getProfile())
        switch resultArray!.count {
        case 1:
            if resultArray?.first == "clearing"{
                resultLabel.frame = helpView.frame
                resultLabels.append(resultLabel)
                for items in headLabels{
                    items.removeFromSuperview()
              }
            for items in textBtns{
                  items.removeFromSuperview()
              }
            for items in resultLabels{
                  items.removeFromSuperview()
              }
            }else if resultArray?.first == "starting"{
                let nextVC = MissionOneVC()
            self.present(nextVC, animated: true, completion: nil)
            return
            }else{
            resultLabel.text = resultArray?.first
            resultLabel.frame = nextLabelRect
            resultLabels.append(resultLabel)
            self.view.addSubview(resultLabel)
            }
        case 0:
                print("error")
        default:
            for index in 0...resultArray!.count - 1{
                let resultLabelArray = UILabel()
                resultLabelArray.boundscolour()
                resultLabelArray.textColor = UIColor.white
                resultLabelArray.textAlignment = .left
                resultLabelArray.font = UIFont(name: "Menlo", size: 11)
                resultLabelArray.text = resultArray![index]
                resultLabelArray.frame = nextLabelRect
                self.view.addSubview(resultLabelArray)
                print(resultLabelArray.frame)
                resultLabels.append(resultLabelArray)
                nextLabelRect = CGRect(origin: CGPoint(x:(resultLabels.last?.frame.origin.x)!,y:(resultLabels.last?.frame.maxY)!), size: resultLabelArray.frame.size)
               
                

            }
        }
 
        let nextHeadLabel = UILabel(frame: CGRect(origin: CGPoint(x:(resultLabels.last?.frame.origin.x)!,y:(resultLabels.last?.frame.maxY)!), size: self.headLabel.frame.size))
        nextHeadLabel.textColor = UIColor.white
        nextHeadLabel.font = UIFont(name: "Menlo", size: 11)
        nextHeadLabel.text = headLabel.text
       print(nextHeadLabel.frame)
        let nextTextLabel = UITextField(frame: CGRect(origin: CGPoint(x:nextHeadLabel.frame.maxX,y:(resultLabels.last?.frame.maxY)!), size: self.textLabel.frame.size))
        nextTextLabel.textColor = UIColor.white
        nextTextLabel.font = UIFont(name: "Menlo", size: 11)
        nextLabelRect = CGRect(origin: CGPoint(x:nextHeadLabel.frame.origin.x,y:nextHeadLabel.frame.maxY), size: nextLabelRect.size)
        
        textBtns.last?.isUserInteractionEnabled = false
        nextTextLabel.delegate = self
        textBtns.append(nextTextLabel)
        headLabels.append(nextHeadLabel)
        
        self.view.addSubview(nextHeadLabel)
        self.view.addSubview(nextTextLabel)
        
    }
    

}
extension UILabel{

   func boundscolour(){
    self.layer.borderColor = UIColor.red.cgColor
    self.layer.borderWidth = 1.0
}



}
