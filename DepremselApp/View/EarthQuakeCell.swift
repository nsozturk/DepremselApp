//
//  EarthQuakeCell.swift
//  FayHat
//
//  Created by enes öztürk on 6.04.2023.
//

import UIKit

class EarthQuakeCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var magLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
