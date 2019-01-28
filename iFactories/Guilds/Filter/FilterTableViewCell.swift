//
//  FilterTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 7/23/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import DLRadioButton

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var gidmDL: DLRadioButton!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var imageLB: UIImageView!
    var cellIP: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
