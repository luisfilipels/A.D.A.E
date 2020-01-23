//
//  InicioTableViewCell.swift
//  A.D.A.E
//
//  Created by Gustavo Vasconcelos on 23/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class InicioTableViewCell: UITableViewCell {
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var hourLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
