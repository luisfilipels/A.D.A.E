//
//  SemanaTableViewCell.swift
//  A.D.A.E
//
//  Created by Gustavo Vasconcelos on 24/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class SemanaTableViewCell: UITableViewCell {
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
