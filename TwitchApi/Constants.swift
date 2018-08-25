//
//  Constants.swift
//  TwitchApi
//
//  Created by Admin on 23.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

// https://api.twitch.tv/kraken/
//'https://api.twitch.tv/helix/users?id=44322889'
//m3eiw66b6vaxl4wpzpcngvuh7oapqy
let TWITCH_URLTOP_GAMES =  "https://api.twitch.tv/kraken/games/top?limit=50&client_id=m3eiw66b6vaxl4wpzpcngvuh7oapqy"

let TWITCH_URL_STREAM_BASE = "https://api.twitch.tv/kraken/streams/?game="
let twitchId = "&client_id=m3eiw66b6vaxl4wpzpcngvuh7oapqy"
let twitchUrlEmbedBase = "https://twitch.tv"
let twitchUrlEmbed = "embed/"
let streamUrlDeepLink = "twitch://open?stream="



typealias downLoadComplete = () -> ()
