//
//  ViewController.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let seriesService = SeriesService()
    var series: [Serie] = []
    let numberOfColumns: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
         self.searchBar.delegate = self

        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        flowLayout()
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
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
        let serie = series[indexPath.row]
        
        cell.imageUrl = serie.imageURL?.medium ?? "null"
        cell.setData(with: serie.imageURL?.medium ?? "null")
            
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
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

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
