//
//  Feed.swift
//  BilibiliTopShelp
//
//  Created by fengyn on 2023/1/7.
//

import Foundation
import TVServices
protocol DisplayData: Hashable {
    var title: String { get }
    var ownerName: String { get }
    var pic: URL? { get }
    var avatar: URL? { get }
    var date: String? { get }
}

protocol PlayableData: DisplayData {
    var aid: Int { get }
    var cid: Int { get }
}

extension DisplayData {
    var avatar: URL? { return nil }
    var date: String? { return nil }
}

struct FeedData: Decodable, PlayableData {
    struct Bangumi: Decodable, Hashable {
        let season_id: Int
        let title: String
        let cover: URL
        struct EP: Decodable, Hashable {
            let index: String
            let index_title: String?
            let episode_id: Int
        }

        let new_ep: EP
    }

    struct Archive: Decodable, Hashable {
        let title: String
        let cid: Int
        let owner: VideoOwner
        let pic: URL
        let redirect_url: URL?
    }

    let id: Int
    let pubdate: Int
    let bangumi: Bangumi?
    let archive: Archive?

    // PlayableData
    var cid: Int { 0 }
    var aid: Int { id }

    // DisplayData
    var title: String { (archive != nil) ? archive!.title : bangumi!.title }
    var ownerName: String { (archive != nil) ? archive!.owner.name : bangumi!.title }
    var pic: URL? { (archive != nil) ? archive!.pic : bangumi!.cover }
    var avatar: URL? { URL(string: archive?.owner.face ?? "") }
    var date: String? { DateFormatter.stringFor(timestamp: pubdate) }
}

struct FeedResp: DisplayData, Codable {
    let can_play: Int?
    let title: String
    let param: String
    let args: Args
    let idx: Int
    let cover: String
    let goto: String
    let rcmd_reason: String?

    var ownerName: String {
        return args.up_name ?? ""
    }

    var pic: URL? {
        return URL(string: cover)
    }

    var date: String? { rcmd_reason }
}

struct Args: Codable, Hashable {
    let up_name: String?
//            let aid: Int?
}

extension FeedResp: PlayableData {
    var aid: Int { Int(param) ?? 0 }
    var cid: Int { 0 }
}

extension FeedResp {
    func makeFeedRespCarouselItem() -> TVTopShelfCarouselItem {
        let item = TVTopShelfCarouselItem(identifier: String(aid))
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
        displayComponents.queryItems = [URLQueryItem(name: "aid", value: String(aid))]

        var playComponents = URLComponents()
        playComponents.scheme = "bilibilitopshelfapp"
        playComponents.queryItems = [URLQueryItem(name: "aid", value: String(aid)), URLQueryItem(name: "play", value: "1")]

        item.displayAction = displayComponents.url.map { TVTopShelfAction(url: $0) }
        item.playAction = playComponents.url.map { TVTopShelfAction(url: $0) }

        return item
    }
}

extension DateFormatter {
    static let date = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater
    }()

    static func stringFor(timestamp: Int?) -> String? {
        guard let timestamp = timestamp else { return nil }
        return date.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
}
