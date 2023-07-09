//
//  Hot.swift
//  BilibiliTopShelp
//
//  Created by fengyn on 2023/1/7.
//

import Foundation
import TVServices
struct HotResp: Codable, Hashable {
    let aid: Int
    let cid: Int
    let title: String
    let videos: Int?
    let pic: URL?
    let desc: String?
    let owner: VideoOwner
    let pages: [VideoPage]?
    let dynamic: String?
    let tname: String?
    let bvid: String?
    let duration: Int
    let pubdate: Int?
    let ugc_season: UgcSeason?
    let redirect_url: URL?
    let stat: Stat
    struct Stat: Codable, Hashable {
        let favorite: Int
        let coin: Int
        let like: Int
        let share: Int
        let danmaku: Int
        let view: Int
    }

    struct UgcSeason: Codable, Hashable {
        let id: Int
        let title: String
        let cover: URL
        let mid: Int
        let intro: String
        let attribute: Int
        let sections: [UgcSeasonDetail]

        struct UgcSeasonDetail: Codable, Hashable {
            let season_id: Int
            let id: Int
            let title: String
            let episodes: [UgcVideoInfo]
        }

        struct UgcVideoInfo: Codable, Hashable, DisplayData {
            var ownerName: String { "" }
            var pic: URL? { arc.pic }
            let aid: Int
            let cid: Int
            let arc: Arc
            let title: String

            struct Arc: Codable, Hashable {
                let pic: URL
            }
        }
    }

    var durationString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .brief
        return formatter.string(from: TimeInterval(duration)) ?? ""
    }
}

struct VideoOwner: Codable, Hashable {
    let mid: Int
    let name: String
    let face: String
}

struct VideoPage: Codable, Hashable {
    let cid: Int
    let page: Int
    let from: String
    let part: String
}

extension HotResp {
    func makeHotRespCarouselItem() -> TVTopShelfCarouselItem {
        let item = TVTopShelfCarouselItem(identifier: String(aid))
        item.title = title
        item.summary = "\(title)"
        item.genre = owner.name
        item.duration = TimeInterval(duration)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
//        item.creationDate = dateformatter.date(from: String(date!))

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
