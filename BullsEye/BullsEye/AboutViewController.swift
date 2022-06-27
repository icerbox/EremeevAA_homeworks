import UIKit
import WebKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
        let request = URLRequest(url: url)
        webView.load(request)
      }

    }
      
  @IBAction func close(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var webView: WKWebView!
  
}


