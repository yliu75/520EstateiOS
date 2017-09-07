//
//  ComplexTableViewCell.swift
//  iOS520Estate
//
//  Created by Yonglun Liu on 2017/9/6.
//  Copyright © 2017年 YonglunTech. All rights reserved.
//

import UIKit

class ComplexTableViewCell: UITableViewCell {

    @IBOutlet weak var Card: UIView!
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var other: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Card.layer.cornerRadius=4
        Card.layer.shadowRadius=3
        Card.layer.shadowColor=UIColor.black.cgColor
        Card.layer.shadowOpacity=0.35
        Card.layer.shadowOffset=CGSize(width:0,height:0)
        Card.layer.borderWidth = 0.5
        Card.layer.borderColor=imageBorderColor.cgColor
        self.backgroundColor=complexBackgroundColor
        cover.clipsToBounds=true
        cover.layer.borderWidth = 0.5
        cover.layer.borderColor=imageBorderColor.cgColor
        
        
        price.textColor=priceColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
