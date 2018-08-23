//
//  MyServiceTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 7/10/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class MyServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var dateLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
