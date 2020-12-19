

import UIKit
import IppoPay

class PayVC: UIViewController {
    
    @IBOutlet weak var stackViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var amountTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handelingKeyboard), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handelingKeyboard), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func errorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func payButtonTapped(_ sender: Any) {
        let amount = amountTextField.text
        if let value = Double(amount ?? "0.0") {
            if amount == "" || value <= 0 {
                errorAlert(message: "Please enter valid amount")
            } else {
                PayLog.setLogVisible(debug: true)
                Ippopay.initSDK(publicKey: "Public Key", withDelegate: self)
                let orderData = OrderData()
                orderData.orderId = "order_id"
                Ippopay.makePayment(orderData: orderData)
                
            }
        }
    }
    
    @objc func handelingKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let isKeyboardShow = notification.name == UIResponder.keyboardWillShowNotification
            stackViewBottomConstraints.constant =  isKeyboardShow ? keyboardSize.height : 0
            UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (isSuccess) in
            }
        }
    }

}

extension PayVC: IppopayDelegate {
    
    func onPaymentError(descriptionOfError: String) {
        print("DescriptionError:::::::::::\(descriptionOfError)")
    }
    
    func onPaymentSuccess(paymentId: String) {
        print("TransactionID:::::::::\(paymentId)")
    }
    
}
