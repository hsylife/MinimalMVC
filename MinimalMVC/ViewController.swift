import UIKit

class ViewController: UIViewController {
    let kUserDefaultsKey: String = "text"
    
    @IBOutlet private var textField: UITextField! {
        didSet {
            textField.text = nil
        }
    }
    
    @IBOutlet private var label: UILabel! {
        didSet {
            label.text = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func onEditingChanged(_ sender: UITextField) {        
        updateLabelText()
        
        guard let string = textField.text else {
            storeTextIntoRepository(nil)
            return
        }
        let text = Text(rawValue: string)
        storeTextIntoRepository(text)
    }
}

private extension ViewController {
    func initUI() {
        textField.text = getTextFromRepository()?.rawValue
        updateLabelText()
    }
    
    func updateLabelText() {
        label.text = createReversedString(textField.text)
    }

    func createReversedString(_ string: String?) -> String? {
        guard let string = string else { return nil }
        return String(string.reversed())
    }

    func getTextFromRepository() -> Text? {
        guard let data = UserDefaults.standard.data(forKey: kUserDefaultsKey) else { return nil }
        return try? JSONDecoder().decode(Text.self, from: data)
    }
    
    func storeTextIntoRepository(_ text: Text?) {
        guard let text = text else {
            UserDefaults.standard.set(nil, forKey: kUserDefaultsKey)
            return
        }
        let data = try? JSONEncoder().encode(text)
        UserDefaults.standard.set(data, forKey: kUserDefaultsKey)
    }    
}
