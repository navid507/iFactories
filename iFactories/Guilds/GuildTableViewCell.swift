//
//  GuildTableViewCell.swift
//  iFactories
//
//  Created by navid einackchi on 7/21/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit

class GuildTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLC: NSLayoutConstraint!
     @IBOutlet weak var backIV: UIImageView!
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
