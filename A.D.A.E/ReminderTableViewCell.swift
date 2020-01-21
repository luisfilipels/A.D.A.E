//
//  ReminderTableViewCell.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 21/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var reminderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeView.layer.cornerRadius = 10
        timeView.layer.shadowOffset = CGSize(width: 0, height: 3)
        timeView.layer.shadowRadius = 1
        timeView.layer.shadowOpacity = 1
        timeView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.06)
        
        reminderButton.layer.cornerRadius = 10
        reminderButton.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
