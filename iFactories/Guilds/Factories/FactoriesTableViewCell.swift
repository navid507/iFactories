//
//  FactoriesTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 7/21/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class FactoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var backIV: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    var fID = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
