//
//  MateriaTableViewCell.swift
//  A.D.A.E
//
//  Created by Gustavo Vasconcelos on 23/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class MateriaTableViewCell: UITableViewCell {

    @IBOutlet weak var materiaTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
