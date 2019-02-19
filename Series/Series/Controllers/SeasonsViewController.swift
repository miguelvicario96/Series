//
//  SeasonsViewController.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var serieId: Int?
    let seriesService = SeriesService()
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.dataSource = self
        
        fetchEpisodes()
        print(episodes)
    }
    
    func fetchEpisodes() {
    

    }
}

//extension SeasonsViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return episodes.count
//    }
//
//
//
//}
