//
//  ServicesTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 7/5/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import DLRadioButton
class ServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceRB: DLRadioButton!
    
    @IBOutlet weak var titleLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
