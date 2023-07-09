//
//  Raking.swift
//  BilibiliTopShelp
//
//  Created by fengyn on 2023/1/7.
//

import Foundation
import TVServices
struct RakingInfos: Codable, Hashable {
    let aid: Int
    let cid: Int
    let title: String
    let videos: Int?
    let pic: URL?
    let desc: String?
    let dynamic: String?
    let tname: String?
    let bvid: String?
    let duration: Int
    let pubdate: Int?
    let redirect_url: URL?
}

extension RakingInfos {
    func makeRankingCarouselItem() -> TVTopShelfCarouselItem {
        let item = TVTopShelfCarouselItem(identifier: String(aid))
        item.title = title
        item.summary = "\(title)\n\(desc ?? "")"
        item.genre = tname
        item.duration = TimeInterval(duration)

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        item.creationDate = dateformatter.date(from: String(pubdate!))

        item.setImageURL(pic, for: .screenScale1x)
        item.setImageURL(pic, for: .screenScale2x)

        var displayComponents = URLComponents()
        displayComponents.scheme = "bilibilitopshelfapp"
        displayComponents.queryItems = [URLQueryItem(name: "aid", value: String(aid))]

        var playComponents = URLComponents()
        playComponents.scheme = "bilibilitopshelfapp"
        playComponents.queryItems = [URLQueryItem(name: "aid", value: String(aid)), URLQueryItem(name: "play", value: "1")]

        item.displayAction = displayComponents.url.map { TVTopShelfAction(url: $0) }
        item.playAction = playComponents.url.map { TVTopShelfAction(url: $0) }
        return item
    }
}
