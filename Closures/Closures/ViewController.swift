import UIKit

class ViewController: UIViewController {
    
    var jsonString = String()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Thread.current)
        NetworkService.fetch { [weak self] json, error in
            guard let self = self else {return}
            print(Thread.current)
            
            DispatchQueue.main.async {
                guard let json = json else { return }
                self.jsonString = json
            }
        }
    }
    
    let numbers = [1, 2, 3, 4, 5, 6]
    
    func increment(by number: Int, to array: [Int]) -> [Int] {
        var result: [Int] = []
        for element in array {
            result.append(element + number)
        }
        return result
    }
    
    let result1 = increment(by: 2, to: numbers)
    
    @IBAction func pressAction(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = stb.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        vc.callBack = { name in
            print(name)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
