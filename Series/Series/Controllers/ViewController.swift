//
//  ViewController.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    let seriesService = SeriesService() //Service
    var series: [Serie] = []    //Series Array
    let numberOfColumns: CGFloat = 3    //Number of columns for view layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self   //Protocols
        self.collectionView.delegate = self
         self.searchBar.delegate = self

        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")   //Cell Register
        
        flowLayout()    //UI Configuration
    }

    func flowLayout() {
        if let collectionViewFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth = (view.frame.width * 0.96 ) / numberOfColumns
            let cellheight = (view.frame.height * 0.96 ) / numberOfColumns
            collectionViewFlowLayout.itemSize.width = cellWidth
            collectionViewFlowLayout.itemSize.height = cellheight
        }
    }
}

extension ViewController: UISearchBarDelegate {
    //Fetch data with searchbar changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        seriesService.getSeries(query: searchText) { (series) in
            if let series = series, series.isEmpty == false {
                self.series = series
            }
            else {
                self.series = []
            }
            self.collectionView.reloadData()
        }
    }
    //Dismiss searchbar keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

extension ViewController: UICollectionViewDataSource {
    //Collectionview number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    //Data set
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
        let serie = series[indexPath.row]
        
        cell.imageUrl = serie.imageURL?.medium ?? "null"
        cell.setData(with: serie.imageURL?.medium ?? "null")
            
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    //Segue to next view 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPathSelected = collectionView.indexPathsForSelectedItems?.first else { return }
        if segue.identifier == "DetailSegue"{
            let detailViewData = segue.destination as? DetailViewController
            let selectedSerie = series[indexPathSelected.row]
            detailViewData?.serie = selectedSerie
        }
    }
}
