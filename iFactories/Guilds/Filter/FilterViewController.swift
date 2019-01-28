//
//  FilterViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/23/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
protocol Filtering {

    func doFilter(g: NSMutableArray, d: NSMutableArray, i: NSMutableArray, m: NSMutableArray, guilds: NSMutableArray)
}
class FilterViewController: UIViewController {

    public var delegate: Filtering?
    public var myGuilds = NSMutableArray()
    private var ftvc: FiltersTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
           
        if let vc = segue.destination as? FiltersTableViewController {
            
           
            let g = NSMutableArray()
            let d = NSMutableArray()
            let i = NSMutableArray()
            let m = NSMutableArray()
            
            for gdim in FactoriesViewController.myGDIMs
            {
                if let cg = gdim as? GDIM
                {
                    let typeID = cg.type
                    switch typeID
                    {
                    case Settings.OthersType.DWay:
                        d.add(cg)
                        break
                    case Settings.OthersType.Geo:
                        g.add(cg)
                        break
                    case Settings.OthersType.Standards:
                        i.add(cg)
                        break
                    case Settings.OthersType.Currency:
                        m.add(cg)
                        break
                    default :
                        break
                    }

                    
                }
            }
            vc.guilds = myGuilds
            vc.dway = d
            vc.geo = g
            vc.currency = m
            vc.standard = i
            self.ftvc = vc
            //self.owvc?.delegate = self
        }
        
    }
    

    @IBAction func getFilterResult(_ sender: Any) {
        delegate?.doFilter(g: (self.ftvc?.geo)!, d: (self.ftvc?.dway)!, i: (self.ftvc?.standard)!, m: (self.ftvc?.currency)!, guilds: (self.ftvc?.guilds)!)
        self.navigationController?.popViewController(animated: true)
    }
    
}
