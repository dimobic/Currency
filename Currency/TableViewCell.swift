//
//  TableViewCell.swift
//  Currency
//
//  Created by Dima Chirukhin on 26.08.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lCur: UILabel!
    @IBOutlet weak var Lcour: UILabel!
    @IBOutlet weak var imageflag: UIImageView!
    
    func initcell(curency:currency){
        imageflag.image = curency.imagef
        lCur.text = curency.Name
        Lcour.text = curency.Value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
