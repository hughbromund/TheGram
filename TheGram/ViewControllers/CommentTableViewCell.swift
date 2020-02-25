//
//  CommentTableViewCell.swift
//  TheGram
//
//  Created by Hugh Bromund on 2/24/20.
//  Copyright © 2020 Hugh Bromund. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    let orange = UIColor(red:1.00, green:0.45, blue:0.08, alpha:1.0)
    let white = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    let grey = UIColor(red:0.23, green:0.21, blue:0.21, alpha:1.0)
    let darkGrey = UIColor(red:0.14, green:0.13, blue:0.13, alpha:1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        usernameLabel.textColor = orange
        commentLabel.textColor = white
        self.backgroundColor = darkGrey
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
