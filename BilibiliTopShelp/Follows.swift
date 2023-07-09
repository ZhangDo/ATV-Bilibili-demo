//
//  Follows.swift
//  BilibiliTopShelp
//
//  Created by fengyn on 2023/1/7.
//

import Foundation
import TVServices
struct FollowsResp: Codable, Hashable {
    let id: Int
    let archive: Archive
}

struct Archive: Codable, Hashable {
    let title: String
    let owner: Owner
    let pic: String
    var cover: URL? {
        return URL(string: pic)
    }
}

struct Owner: Codable, Hashable {
    let name: String
    let face: String
}

extension FollowsResp {
    func makeFollowsRespCarouselItem() -> TVTopShelfCarouselItem {
        let item = TVTopShelfCarouselItem(identifier: String(id))
        item.title = archive.title
        item.summary = "\(archive.title)"
        item.genre = archive.owner.name

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
//        item.creationDate = dateformatter.date(from: String(date!))

        item.setImageURL(archive.cover, for: .screenScale1x)
        item.setImageURL(archive.cover, for: .screenScale2x)

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
