import UIKit

class SecondViewController: UIViewController {
    
    public var callBack: (([String]) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func popAction(_ sender: Any) {
        callBack?(["Jack"])
        self.navigationController?.popViewController(animated: true)
    }
    
}



