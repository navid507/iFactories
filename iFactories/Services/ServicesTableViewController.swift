//
//  ServicesTableViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/5/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import DLRadioButton
class ServicesTableViewController: UITableViewController {

    public var services = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTableViewCell", for: indexPath) as! ServicesTableViewCell
        if let service = services[indexPath.row] as? Service
        {
//            cell.serviceRB.setTitle(service.name, for: .normal)
            cell.titleLB.text = service.name
            cell.serviceRB.isSelected = service.state
            cell.serviceRB.tag = service.id
            cell.serviceRB.addTarget(self, action: #selector(ServicesTableViewController.doSelectService), for: .touchUpInside)
            if (MainInfo.IsRTL)
            {
                cell.serviceRB.contentHorizontalAlignment = .right
                cell.titleLB.font = UIFont(name: "B Roya", size: 16)
//                cell.serviceRB.titleLabel?.font = UIFont(name: "B Roya", size: 16)
            }else
            {
                cell.serviceRB.contentHorizontalAlignment = .left
//                cell.serviceRB.titleLabel?.font =
                cell.titleLB.font = UIFont(name: "System", size: 14)
                
            }
        }

//        cell.alBT.isSelected = al.selected
//        cell.alBT.tag = indexPath.row
//
        
        
        
        // Configure the cell...

        return cell
    }
    
    @objc func doSelectService(_ sender: DLRadioButton) {
        for ser in services
        {
            if let service = ser as? Service
            {
                if service.id == sender.tag
                {
                    service.state = !service.state
                }
            }
        }
//        for (i, al) in services{
//            if let cal = al as? CAirLineC
//            {
//                if (i == sender.tag)
//                {
//                    cal.selected = true
//                } else{
//                    cal.selected = false
//                }
//            }
//
//        }
        self.tableView.reloadData()
        //als[sender.tag]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
