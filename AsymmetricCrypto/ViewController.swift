//
//  ViewController.swift
//  AsymmetricCrypto
//
//  Created by Ignacio Nieto Carvajal on 4/10/15.
//

import UIKit

class ViewController: UIViewController, ModalViewControllerDelegate {
    // MARK: - outlets && buttons
    @IBOutlet weak var keyPairLabel: UILabel!
    @IBOutlet weak var keyPairButton: UIButton!
    
    @IBOutlet weak var keyScreen: UIButton!
    
    @IBOutlet weak var clearTextTextfield: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var cypheredTextTextfield: UITextField!
    @IBOutlet weak var verifySignatureButton: UIButton!
    
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    
//    var infoArr: [String] = (clearTextTextfield.text, secondTextField.text, thirdTextField.text, fourthTextField.text)
    
    // data
    var keyPairExists = AsymmetricCryptoManager.sharedInstance.keyPairExists() {
        didSet {
            if keyPairExists {
                keyPairLabel.text = "A valid keypair is present"
                keyPairButton.setTitle("Delete keypair", forState: .Normal)
            } else {
                keyPairLabel.text = "No key pair present"
                keyPairButton.setTitle("Generate keypair", forState: .Normal)
            }
            signButton.enabled = keyPairExists
            verifySignatureButton.enabled = keyPairExists
        }
    }
    
    func parseQRCode(dataFromQR : String){
        var clearText = ""
        var digitalSignature = ""
        
        // TODO: parse appart cleartext and signature
        
        clearTextTextfield.text = clearText
        cypheredTextTextfield.text = digitalSignature
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: parse QR data
        AsymmetricCryptoManager.sharedInstance.setDataInQR("")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.keyPairExists = AsymmetricCryptoManager.sharedInstance.keyPairExists()
    }

    // MARK: - button actions
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func doneViewingHelp(sender: UIStoryboardSegue){
        cypheredTextTextfield.text = ""
        
    }
    
    @IBAction func generateKeyPair(sender: AnyObject) {
        self.view.userInteractionEnabled = false
        if keyPairExists { // delete current key pair
            AsymmetricCryptoManager.sharedInstance.deleteSecureKeyPair({ (success) -> Void in
                if success {
                    self.showAlertWithFadingOutMessage("Keypair successfully deleted")
                    self.keyPairExists = false
                } else { self.showAlertWithFadingOutMessage("Error deleting keypair.") }
                self.view.userInteractionEnabled = true
            })
        } else { // generate keypair
            AsymmetricCryptoManager.sharedInstance.createSecureKeyPair({ (success, error) -> Void in
                if success {
                    self.showAlertWithFadingOutMessage("RSA-2048 keypair successfully generated.")
                    self.keyPairExists = true
                } else { self.showAlertWithFadingOutMessage("An error happened while generating a keypair: \(error)") }
                self.view.userInteractionEnabled = true
            })
        }
    }
    
    @IBAction func signText(sender: AnyObject) {
        // safety check.
        
        var allText = clearTextTextfield.text!  + secondTextField.text! + thirdTextField.text! + fourthTextField.text!
        
        if allText.isEmpty {
            self.showAlertWithFadingOutMessage("Please, insert the text to be signed in the upper textfield.")
            return
        }
        self.view.userInteractionEnabled = false
        self.cypheredTextTextfield.text = ""
        self.view.endEditing(true)
        AsymmetricCryptoManager.sharedInstance.signMessageWithPrivateKey(allText) { (success, data, error) -> Void in
            if success {
                let b64encoded = data!.base64EncodedStringWithOptions([])
                self.cypheredTextTextfield.text = b64encoded
                
                var clipboardStuff = self.cypheredTextTextfield.text! /*+ "++++++++++" + allText as String*/
                
                UIPasteboard.generalPasteboard().string = clipboardStuff
                
            } else {
                self.showAlertWithFadingOutMessage("Error signing message: \(error)")
            }
            self.view.userInteractionEnabled = true
        }
        
    }
    
    @IBAction func verifySignature(sender: AnyObject) {
        // safety checks.
        
        var allText = clearTextTextfield.text!  + secondTextField.text! + thirdTextField.text! + fourthTextField.text!
        
        if allText.isEmpty {
            self.showAlertWithFadingOutMessage("Please, insert a the text that was signed in the upper textfield.")
            return
        }
        if cypheredTextTextfield.text!.isEmpty {
            self.showAlertWithFadingOutMessage("Please, insert the generated signature in the lower textfield.")
            return
        }
        
        print(cypheredTextTextfield.text!)
        
        guard let rawData = allText.dataUsingEncoding(NSUTF8StringEncoding), let signatureData = NSData(base64EncodedString: cypheredTextTextfield.text!, options: []) else {
            self.showAlertWithFadingOutMessage("Unable to decode or identify input data. Probably one of the input fields is corrupted.")
            return
        }
        self.view.userInteractionEnabled = false
        self.view.endEditing(true)
        AsymmetricCryptoManager.sharedInstance.verifySignaturePublicKey(rawData, signatureData: signatureData) { (success, error) -> Void in
//            
//            if (success){
//                
//            } else {
                self.showAlertWithFadingOutMessage(success ? "Signature verification was successful.": "Error: the signature is not valid for the input text")
//            }
            self.view.userInteractionEnabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        CameraViewController.ModalViewControllerDelegate=self
//        CameraViewController.delegate=self;
        //self.presentViewController(CameraViewController, animated: true, completion: nil)
        if segue.identifier == "showCameraSegue" {
        let destinationVC = segue.destinationViewController as! CameraViewController
        
        destinationVC.delegate = self
            
        } else if segue.identifier == "validSigSegue" {
            let validMessageViewController = segue.destinationViewController as! ValidMessageViewController
            //ValidMessageViewController.labelOneLabelText = clearTextTextfield.text
            //ValidMessageViewController.labelTwoLabelText =
            
        }
        
        
    }
    
    func sendValue(value: NSString) {
        cypheredTextTextfield.text = value as String
        
        print("value recieved is \(value as String)")
    }
    
}

