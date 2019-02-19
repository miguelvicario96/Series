//
//  EpisodesTableViewCell.swift
//  Series
//
//  Created by Miguel Ángel Vicario Flores  on 2/19/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let seriesService = SeriesService() //Service
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.episodeImage.layer.cornerRadius = 5    //Image Configuration
        self.episodeImage.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {   //Spinner
        super.prepareForReuse()
        spinner.startAnimating()
        spinner.isHidden = false
    }

    func setData(with episode: Episode) {
        episodeLabel.text = "Episode \(episode.number): \(episode.name)"    //Set labels
        seasonLabel.text = "Season \(episode.season)"
        if let urlImage = episode.imageURL?.medium {    //Data -> Image
            seriesService.getImage(urlString: urlImage) { (image) in
                if let image = image {
                    self.episodeImage.image = image
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
            }
        }
        else {
            episodeImage.image = UIImage(named: "Error")
        }
        
    }
    
}
