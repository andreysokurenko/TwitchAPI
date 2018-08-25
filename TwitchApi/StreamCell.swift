//
//  StreamCell.swift
//  TwitchApi
//
//  Created by Admin on 25.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class StreamCell: UITableViewCell {

    
    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var broadcasterName: UILabel!
    @IBOutlet weak var steamTitle: UILabel!
    @IBOutlet weak var streamViewers: UILabel!
    
    
    func configureCell(_ stream: Stream) {
        broadcasterName.text = stream.broadcasterName
        steamTitle.text = stream.streamTitle
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        streamViewers.text = "\(formatter.string(from: NSNumber(value: stream.streamViewerCount))!) viewers"
        
        if stream.streamImage != nil {
            streamImageView.image = stream.streamImage
        }
        
        
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
