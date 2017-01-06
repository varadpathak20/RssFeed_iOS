//
//  FeedCell.swift
//  RSSFeed
//
//  Created by Varad on 04/01/17.
//  Copyright © 2017 MobileFirst. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var imgFeedBG: UIImageView!
    @IBOutlet weak var chromeView: UIView!
    @IBOutlet weak var lblFeedTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
