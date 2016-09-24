//
//  TesterTableViewCell.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/20/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit

class TesterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
//    @IBOutlet weak var postImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


