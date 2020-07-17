//
//  JokeCell.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/17.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var dislikes: UILabel!
    
    var joke: Joke? {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI() {
        if let joke = joke {
            descriptionLabel.text = joke.jokeDescription
            likes.text = "\(joke.likes ?? 0) likes"
            dislikes.text = "\(joke.dislikes ?? 0) dislikes"
        }
    }
}
