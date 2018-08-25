//
//  StreamsViewController.swift
//  TwitchApi
//
//  Created by Admin on 25.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var streamsTableView: UITableView!
    
    var game: Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(game.gameName!)"
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StreamDataService.instance.downloadStreamForGame(game) { 
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage {
                    self.streamsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        StreamDataService.instance.removeAllStreams()
        
    }
    
// MARK: - UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instance.streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath) as? StreamCell {
            
            let stream = StreamDataService.instance.streams[indexPath.row]
            cell.configureCell(stream)
            
            
            return cell
        } else {
            return StreamCell()
        }
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]
        openStream(stream)
    }
    
    //Handler func to open stream in chose app
    
    func openStream(_ stream:  Stream)  {
        let alert = UIAlertController(title: "Open stream in TwitchAPI or in official Twitch App", message: "Official Twitch app must be installed for later option", preferredStyle: .alert)
        let openInTwitchAPIAction = UIAlertAction(title: "TwitchAPI", style: .default) { (action) in
            self.performSegue(withIdentifier: "channelShowVC", sender: stream)
        }
        let openInTwitchAppAction = UIAlertAction(title: "Twitch", style: .default) { (action) in
            
            self.openStreamInTwichApp(stream)
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(openInTwitchAPIAction)
        alert.addAction(openInTwitchAppAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "channelShowVC" {
            if let channelVC = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelVC.stream = stream
                }
            }
        }
    }
    
    func openStreamInTwichApp(_ stream: Stream) {
        let streamString = streamUrlDeepLink + stream.broadcasterName
        if let streamUrl = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamUrl) {
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
                
            }

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
