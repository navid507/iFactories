//
//  FactoryViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/11/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import ImageSlideshow
class FactoryViewController: UIViewController {
    @IBOutlet weak var fNameLB: UILabel!
    @IBOutlet weak var gallerySlider: ImageSlideshow!
    
    @IBOutlet weak var factoryIV: UIImageView!
    var factory: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        let url = URL(string: (factory?.logo)!)
        factoryIV.kf.setImage(with: url)
        
        
        fNameLB.text = factory?.name
        
        // Do any additional setup after loading the view.
        if (MainInfo.IsRTL)
        {
            backBT.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        }
        
        
        showAds()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? CategoryViewController
        {
            CategoryViewController.myCats.removeAllObjects()
            svc.factory = factory
        }else if let svc = segue.destination as? MoreInfoViewController
        {
            
            svc.factory = factory
        }else if let svc = segue.destination as? BridgeViewController
        {
            
            svc.factory = factory
        }
        
    }
    
    func showAds()
    {
        var iis = [KingfisherSource]()
        if let ads = factory?.gallery
        {
            for s in ads
            {
                let source = KingfisherSource(urlString: s)
                iis.append(source!)
            }
            gallerySlider.contentScaleMode = .scaleAspectFill
            gallerySlider.setImageInputs(iis)
            gallerySlider.slideshowInterval = 5
            let pageIndicator = PageControlPosition.insideScrollView
            //        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            //        pageIndicator.pageIndicatorTintColor = UIColor.black
            gallerySlider.pageControlPosition = pageIndicator
        }
    }
    
    
}
