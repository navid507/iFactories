//
//  ProductDetailsViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/13/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var prdIV: UIImageView!
    var product: Product?
    @IBOutlet weak var prdNameLB: UILabel!
    @IBOutlet weak var descLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        // Do any additional setup after loading the view.
        descLB.text = "Both this one and @TJ/@Jorge methods will work. I've gone for this way because it feels cleaner. Benefits that I can see in the other method are that you can see your looping segues in the storyboard, and that you can handle all your navigation in Both this one and @TJ/@Jorge methods will work. I've gone for this way because it feels cleaner. Benefits that I can see in the other method are that you can see your looping segues in the storyboard, and that you can handle all your navigation in Both this one and @TJ/@Jorge methods will work. I've gone for this way because it feels cleaner. Benefits that I can see in the other method are that you can see your looping segues in the storyboard, and that you can handle all your navigation in Both this one and @TJ/@Jorge methods will work. I've gone for this way because it feels cleaner. Benefits that I can see in the other method are that you can see your looping segues in the storyboard, and that you can handle all your navigation in"
    
        prdNameLB.text = product?.name
        descLB.text = product?.desc
        let url = URL(string: (product?.image)!)
        prdIV.kf.setImage(with: url)
    
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
