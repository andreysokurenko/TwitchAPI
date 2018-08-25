//
//  GameCell.swift
//  TwitchApi
//
//  Created by Admin on 24.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell(_ game: Game)  {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
            gameImageView.layer.cornerRadius = 10
            gameImageView.layer.masksToBounds = true
            
        }
    }
}
