//
//  CategoryTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 8/12/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var catNameLB: UILabel!
    @IBOutlet weak var backIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
