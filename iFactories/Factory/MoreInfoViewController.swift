//
//  MoreInfoViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/25/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var descLB: UILabel!
    
    var factory: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        let url = URL(string: (factory?.banner)!)
        imageIV.kf.setImage(with: url)
        
        nameLB.text = factory?.name
        let htmlData = NSString(string: (factory?.standards)!).data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        descLB.attributedText = attributedString
        
        descLB.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        
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
