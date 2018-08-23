//
//  FactoryViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/11/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class FactoryViewController: UIViewController {
    @IBOutlet weak var fNameLB: UILabel!
    
    var factory: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fNameLB.text = factory?.name
        
        // Do any additional setup after loading the view.
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
        }
        
    }
    
    

}
