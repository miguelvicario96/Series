//
//  CollectionViewCell.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let seriesService = SeriesService() //Service
    var imageUrl: String!   //Var for passing data
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 10    //Cell configuration
        self.contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {   //Spinner
        super.prepareForReuse()
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    func setData(with urlImage: String) {
        seriesService.getImage(urlString: urlImage) { (image) in    //Data -> Image
            guard let image = image, urlImage == self.imageUrl else {return}
            self.cellImage.image = image
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
}
