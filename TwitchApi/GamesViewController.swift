//
//  GamesViewController.swift
//  TwitchApi
//
//  Created by Admin on 23.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        title = "Games"
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData), for: UIControlEvents.valueChanged)
        gamesCollectionView.insertSubview(refreshControl, at: 0)
        
        
        
        
        reloadData()
        
            }
    
    func reloadData() {
        
        GameDataServices.instance.downloadTopGames {
            for games in GameDataServices.instance.games {
                games.downloadGameImage(completed: {
                    self.gamesCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
            
        }
    }

 
 //   MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataServices.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCell {
            
            let game = GameDataServices.instance.games[indexPath.row]
            cell.configureCell(game)
            
            
            
            return cell
        } else {
            return GameCell()
        }
         
        
    }
    
    //   MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = GameDataServices.instance.games[indexPath.row]
        
        performSegue(withIdentifier: "streamShowVC", sender: game)
    }

    //   MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (gamesCollectionView.bounds.width / 2) - 15
        let height = width * (4/3)
        
        
        return CGSize(width: width, height: height)
        
    }
    
    //   MARK: Seque
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "streamShowVC" {
            if let streamVC = segue.destination as? StreamsViewController {
                if let game = sender as? Game {
                    streamVC.game = game
                }
            }
        }
    }

    
    
    
    
    
}
