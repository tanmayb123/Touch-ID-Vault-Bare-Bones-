//
//  ViewController.swift
//  TouchIDVault
//
//  Created by Tanmay Bakshi on 2015-01-17.
//  Copyright (c) 2015 Tanmay Bakshi. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var vaultText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func testTouchID() {
        var touchContext: LAContext = LAContext()
        
        if touchContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            touchContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock the vault, tap the Touch ID (home) button.", reply: {
                (success: Bool, error: NSError?) -> Void in
                if success {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.unlock()
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        //***DO NOTHING***
                    })
                }
            })
        } else {
            //***DO NOTHING***
        }
    }
    
    func unlock() {
        self.performSegueWithIdentifier("toVault", sender: self)
    }

    
    @IBAction func save() {
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(vaultText.text, forKey: "vault")
        defaults.synchronize()
    }
    
    @IBAction func load() {
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        vaultText.text = defaults.objectForKey("vault") as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

