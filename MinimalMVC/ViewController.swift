import UIKit

class ViewController: UIViewController {

    @IBOutlet private var textField: UITextField! {
        didSet {
            textField = nil
        }
    }
    
    @IBOutlet private var label: UILabel! {
        didSet {
            label.text = nil
        }
    }
    
    @IBAction func onEditingChanged(_ sender: UITextField) {        
        label.text = createReversedString(sender.text)
    }
    
    private func createReversedString(_ string: String?) -> String? {
        guard let string = string else { return nil }
        return String(string.reversed())
    }
}

