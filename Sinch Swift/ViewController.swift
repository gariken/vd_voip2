//
//  ViewController.swift
//  Sinch Swift
//
//  Created by Artyom Savelyev on 03.03.17.
//  Copyright © 2017 iOS Center. All rights reserved.
//

import UIKit


class ViewController: UIViewController, SINCallClientDelegate, SINCallDelegate
{
    var client: SINClient? = nil
    var call: SINCall? = nil
    
    
    @IBOutlet weak var toUserName: UITextField!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad()
    {
        
        client = Sinch.client(withApplicationKey: "91668355-05ff-45dd-980a-a2fa958d3d92", applicationSecret: "gmEUrqo3ckypTCsD3BKtLA==", environmentHost: "sandbox.sinch.com", userId: "art")

        client?.call().delegate = self
        client?.setSupportCalling(true)
        client?.start()
        
        client?.startListeningOnActiveConnection()
        
         super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func callClick(_ sender: Any)
    {
        if (callButton.title(for: .normal) == "Answer")
        {
            call?.answer()
            callButton.setTitle("Hangup", for: .normal)
            return
        }
        if (callButton.title(for: .normal) == "Hangup")
        {
            call?.hangup()
            callButton.setTitle("Call", for: .normal)
            call = nil
            return
        }
        
        if (toUserName.text?.isEmpty)!
        {
            print ("Name string is empty")
            return
        }
        
        if (call == nil)
        {
            call = client?.call().callUser(withId: toUserName.text)
            callButton.setTitle("Hangup", for: .normal)
        }
    }
    
    func client(_ client: SINCallClient!, didReceiveIncomingCall inputCall: SINCall!)
    {
        infoLabel.text = "You have incoming call"
        callButton.setTitle("Answer", for: .normal)
        call = inputCall
        call?.delegate = self
    }

    func callDidEnd(_ inputCall: SINCall!)
    {
        infoLabel.text = "Call did end";
        callButton.setTitle("Call", for: .normal)
        call = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

