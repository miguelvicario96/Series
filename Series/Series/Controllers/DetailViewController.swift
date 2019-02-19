//
//  DetailViewController.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!    //Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var transmitterLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonsButton: UIButton!
    
    var serie: Serie?   //Var for passing data
    let seriesService = SeriesService() //Service
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTextView.isEditable = false //Editable
        uiConfiguration() //UI Configuration
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        infoTextView.setContentOffset(.zero, animated: true)    //Scroll to the top
    }
    
    func uiConfiguration() {
        nameLabel.text = serie?.name    //Sets Labels
        infoTextView.text = serie?.summary.clearTags()
        transmitterLabel.text = serie?.network?.name ?? "Not available"
        
        webButton.layer.cornerRadius = 10   //Button Configuration
        webButton.layer.masksToBounds = true
        
        seasonsButton.layer.cornerRadius = 10   //Button Configuration
        seasonsButton.layer.masksToBounds = true
        
        hourLabel.text = serie?.schedule.time //Sets Labels
        daysLabel.text = daysToString(days: (serie?.schedule.days)!)
        spinner.startAnimating()
        seriesService.getImage(urlString: serie?.imageURL?.original ?? "null") { (image) in //Data -> Image
            if let image = image {
                self.detailImage.image = image
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
    }
    
    func daysToString(days: [String]) -> String {   //Set string
        return days.reduce("", {$0 + $1 + " "})
    }
    
    @IBAction func webAction(_ sender: UIButton) {  //Open url
        guard let urlString = serie?.officialSite, let url = URL(string: urlString ) else {return}
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Segue to next view
        if segue.identifier == "EpisodesSegue"{
            let episodesView = segue.destination as? SeasonsViewController
            episodesView?.serieId = serie?.id
        }
    }
}
