//
//  KeysViewController.swift
//  AsymmetricCrypto
//
//  Created by Steven Povlitz on 4/2/16.
//

import UIKit

class KeysViewController: UIViewController {
    
    @IBOutlet weak var publicKeyTextField: UITextField!
    
    @IBOutlet weak var privateKeyTextField: UITextField!
    
    var keyPairExists = AsymmetricCryptoManager.sharedInstance.keyPairExists() {
        didSet {
            if keyPairExists {
                // TODO: Fill the key text boxes with the keys, maybe make a gen key button grey?
                
            } else {
                // TODO: notate that the key fiends are empty, maybe make a generate key button not grey?
                
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keyPairExists {
            publicKeyTextField.text = "\(AsymmetricCryptoManager.sharedInstance.getPublicKeyData()!)"
            privateKeyTextField.text = "\(AsymmetricCryptoManager.sharedInstance.getPrivateKeyReference()!)"
        } else {
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.keyPairExists = AsymmetricCryptoManager.sharedInstance.keyPairExists()
    }
    
   
    @IBAction func importKeysButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {} )
    }
    

}
