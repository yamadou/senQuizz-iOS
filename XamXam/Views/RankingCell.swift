//
//  RankingCell.swift
//  XamXam
//
//  Created by Yamadou Traore on 5/2/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import SDWebImage

class RankingCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankCountLabel: UILabel!
    @IBOutlet weak internal var profileImageView: UIImageView!
    @IBOutlet weak internal var medalImageView: UIImageView!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            
            playerNameLabel.text = model.playerName
            scoreLabel.text = "\(model.score) PTS"
            
            rankCountLabel.isHidden = true
            
            if model.index == 0 {
                medalImageView.image = UIImage(named: "goldMedal")
            } else if model.index == 1 {
                medalImageView.image = UIImage(named: "silverMedal")
            } else if model.index == 2 {
                medalImageView.image = UIImage(named: "bronzeMedal")
            } else {
                medalImageView.image = UIImage(named: "")
                rankCountLabel.text = "\(model.index + 1)"
                rankCountLabel.isHidden = false
            }
            
            if
                let profileImagePath = model.profileImageUrl,
                let profileImageUrl = URL(string: profileImagePath) {
                    profileImageView.sd_setImage(with: profileImageUrl)
            } else {
                profileImageView.image = UIImage(named: "profileImage")
            }
            
            profileImageView.layer.borderWidth = 1.0
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.borderColor = UIColor.darkGray.cgColor
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
            
            self.layer.borderWidth = 1
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 5
            self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            self.clipsToBounds = true
        }
    }
}

extension RankingCell {
    struct Model {
        var playerName = "No Name"
        var score = 0
        var profileImageUrl: String?
        var index = 0
        
        init(stat: GameStat, index: Int) {
            self.index = index
            self.playerName = stat.playerName
            self.score = stat.score
            
            if let profileImageUrl = stat.profileImageUrl {
                self.profileImageUrl = profileImageUrl
            }
        }
    }
}
