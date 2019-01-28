//
//  FiltersTableViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/23/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import DLRadioButton
class FiltersTableViewController: UITableViewController {
//    public var myFilters = NSMutableArray()
   
    public var guilds = NSMutableArray()
    public var currency = NSMutableArray()
    public var geo = NSMutableArray()
    public var dway = NSMutableArray()
    public var standard = NSMutableArray()
    
    
    
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
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case Settings.OthersType.Guild:
            return guilds.count
        case Settings.OthersType.Standards:
            return standard.count
        case Settings.OthersType.DWay:
            return dway.count
        case Settings.OthersType.Geo:
            return  geo.count
        case Settings.OthersType.Currency:
            return currency.count
        default:
            return 0
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell

        var title: String = ""
        var image: String = ""
        var selected: Bool = false
        // Configure the cell...
        
        
        (title, selected, image) = getElement(sec: indexPath)
        
        ////////////
        cell.nameLB.text = title
        cell.nameLB.font = UF.getFont(tag: cell.nameLB.tag, lang: MainInfo.language)
        let url = URL(string: image)
        cell.imageLB.kf.setImage(with: url)
        
        cell.gidmDL.isSelected = selected
        cell.cellIP = indexPath
        cell.gidmDL.addTarget(self, action: #selector(FiltersTableViewController.doSelectService), for: .touchUpInside)
//        if (MainInfo.IsRTL)
//        {
//            cell.gidmDL.contentHorizontalAlignment = .right
//            cell.gidmDL.titleLabel?.font = UF.getFont(tag: 16, lang: MainInfo.language)
//            //            cell.gidmDL.isIconOnRight = true
//        }else
//        {
//            cell.gidmDL.contentHorizontalAlignment = .left
//            cell.gidmDL.titleLabel?.font = UF.getFont(tag: 16, lang: MainInfo.language)
//            //            cell.gidmDL.isIconOnRight = false
//
//        }
//        cell.gidmDL.addTarget(self, action: #selector(FiltersTableViewController.doSelectService), for: .touchUpInside)
//        ////////
        return cell
    }
    @objc func doSelectService(_ sender: DLRadioButton) {
//        sender.isSelected = !sender.isSelected
        for cell in tableView.visibleCells {
            if let cc = cell as? FilterTableViewCell
            {
                if (sender.isEqual(cc.gidmDL))
                {
                    let sec = cc.cellIP!
                    switch sec.section {
                    case Settings.OthersType.Guild:
                         if let cg = guilds[sec.row] as? Guild
                        {
                           cg.selected = !cg.selected
                            sender.isSelected = cg.selected
                        }
                        break
                    case Settings.OthersType.Standards:
                        if let cg = standard[sec.row] as? GDIM
                        {
                            cg.selected = !cg.selected
                            sender.isSelected = cg.selected
                        }
                        break
                    case Settings.OthersType.DWay:
                        if let cg = dway[sec.row] as? GDIM
                        {
                            cg.selected = !cg.selected
                            sender.isSelected = cg.selected
                        }
                        break
                    case Settings.OthersType.Geo:
                        if let cg = geo[sec.row] as? GDIM
                        {
                            cg.selected = !cg.selected
                            sender.isSelected = cg.selected
                        }
                        break
                    case Settings.OthersType.Currency:
                        if let cg = currency[sec.row] as? GDIM
                        {
                            cg.selected = !cg.selected
                            sender.isSelected = cg.selected
                        }
                        break
                    default:
                        break
                        
                    }
                }
            }
        }
        self.tableView.reloadData()
        //als[sender.tag]
    }
    func getElement(sec: IndexPath)-> (String, Bool, String)
    {
        switch sec.section {
        case Settings.OthersType.Guild:
            if let cg = guilds[sec.row] as? Guild
            {
                return (cg.name, cg.selected, cg.image)
            }
            break
        case Settings.OthersType.Standards:
            if let cg = standard[sec.row] as? GDIM
            {
                return (cg.name, cg.selected, cg.image)
            }
            break
        case Settings.OthersType.DWay:
            if let cg = dway[sec.row] as? GDIM
            {
                return (cg.name, cg.selected, cg.image)
            }
            break
        case Settings.OthersType.Geo:
            if let cg = geo[sec.row] as? GDIM
            {
                return (cg.name, cg.selected, cg.image)
            }
            break
        case Settings.OthersType.Currency:
            if let cg = currency[sec.row] as? GDIM
            {
                return (cg.name, cg.selected, cg.image)
            }
            break
        default:
            break
            
        }
        return ("", false,"")
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Settings.OthersType.Guild:
           return "Guild".localized()
        case Settings.OthersType.Standards:
            return "Standard".localized()
        case Settings.OthersType.DWay:
            return "DWay".localized()
        case Settings.OthersType.Geo:
           return  "Geo".localized()
        case Settings.OthersType.Currency:
            return "Currency".localized()
        default:
            return ""
        }
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
