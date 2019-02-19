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
    
    var serieId: Int? //Var for passing data
    let seriesService = SeriesService() //Service
    
    var episodes: [Episode] = []    //Episodes array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self    //Protocol
        self.tableView.register(UINib(nibName: "EpisodesTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodesTableViewCell")  //Cell Register
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchEpisodes() //Fetch Data
    }
    
    func fetchEpisodes() {
    
        seriesService.getEpisodes(serieID: "\(serieId!)") { (episodes) in
            if let episodes = episodes {
                print(episodes)
                for episode in episodes {
                    self.episodes.append(episode)
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension SeasonsViewController: UITableViewDataSource {
    //Tableview number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    //Data set
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableViewCell", for: indexPath) as! EpisodesTableViewCell
        let episode = episodes[indexPath.row]
        cell.setData(with: episode)
        return cell
    }
    //Rows Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
}
