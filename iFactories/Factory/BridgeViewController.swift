//
//  BridgeViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/25/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class BridgeViewController: UIViewController {

    @IBOutlet weak var addrTV: UITextView!
    @IBOutlet weak var phoneLB: UILabel!
    @IBOutlet weak var mobileLB: UILabel!
    @IBOutlet weak var emailLB: UILabel!
    @IBOutlet weak var webLB: UILabel!
    @IBOutlet weak var contV: UIView!
    
    var factory: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ffd96b
        
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        addrTV.text = factory?.address
        phoneLB.text = factory?.phone
        mobileLB.text = factory?.mobile
        webLB.text = factory?.web
        emailLB.text = factory?.email
        
        if (MainInfo.IsRTL)
        {
            backBT.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        }
        
    }
    @IBOutlet weak var backBT: UIButton!
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
