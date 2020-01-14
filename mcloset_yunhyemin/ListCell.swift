//
//  ListCell.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 18/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var regdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
