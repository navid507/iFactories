//
//  LnaguageViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/4/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class LnaguageViewController: UIViewController {
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setLangEnglish(_ sender: Any) {
       
            UF.doEnglish()
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func setLangRussion(_ sender: Any) {
        
        UF.doRussion()
   self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func setLangArabic(_ sender: Any) {
        
        UF.doArabic()
   self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func setLangPersian(_ sender: Any) {
        
        UF.doPersian()
  self.navigationController?.dismiss(animated: true, completion: nil)
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
