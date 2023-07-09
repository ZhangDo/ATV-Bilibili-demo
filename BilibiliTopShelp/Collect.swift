//
//  Collect.swift
//  BilibiliTopShelp
//
//  Created by fengyn on 2023/1/7.
//

import Foundation
import TVServices
struct Collect: DisplayData, Codable {
    var cover: String
    var upper: VideoOwner
    var id: Int
    var title: String
    var ownerName: String { upper.name }
    var pic: URL? { URL(string: cover) }
}

extension Collect {
    func makeCollectRespCarouselItem() -> TVTopShelfCarouselItem {
        let item = TVTopShelfCarouselItem(identifier: String(id))
        item.title = title
        item.summary = "\(title)"
        item.genre = ownerName

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
//        item.creationDate = dateformatter.date(from: String(date!))

        item.setImageURL(pic, for: .screenScale1x)
        item.setImageURL(pic, for: .screenScale2x)

        var displayComponents = URLComponents()
        displayComponents.scheme = "bilibilitopshelfapp"
        displayComponents.queryItems = [URLQueryItem(name: "aid", value: String(id))]

        var playComponents = URLComponents()
        playComponents.scheme = "bilibilitopshelfapp"
        playComponents.queryItems = [URLQueryItem(name: "aid", value: String(id)), URLQueryItem(name: "play", value: "1")]

        item.displayAction = displayComponents.url.map { TVTopShelfAction(url: $0) }
        item.playAction = playComponents.url.map { TVTopShelfAction(url: $0) }

        return item
    }
}
