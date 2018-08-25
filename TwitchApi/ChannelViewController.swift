//
//  ChannelViewController.swift
//  TwitchApi
//
//  Created by Admin on 25.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import  WebKit

class ChannelViewController: UIViewController {

    var stream: Stream!
    var webView: WKWebView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        let urlString = twitchUrlEmbedBase + stream.broadcasterName + twitchUrlEmbed
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
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
