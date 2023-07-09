//
//  ContentProvider.swift
//  BiliBiliTopShelp
//
//  Created by zhang dong on 2023/2/26.
//

import TVServices

class ContentProvider: TVTopShelfContentProvider {
    override func loadTopShelfContent(completionHandler: @escaping (TVTopShelfContent?) -> Void) {
        // Fetch content and call completionHandler
        DispatchQueue.global().async {
            do {
                let defaults = UserDefaults(suiteName: "group.Bilibili.a")!
                let style = defaults.object(forKey: "topShelf") as! String

                if style.isEqual("排行榜") {
                    let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Bilibili.a")
                    let fileURL = groupURL?.appending(component: "Ranking")
                    let data = try Data(contentsOf: fileURL!)
                    let decode = try JSONDecoder().decode([RakingInfos].self, from: data)
                    let items = decode.map { $0.makeRankingCarouselItem() }
                    let contents = TVTopShelfCarouselContent(style: .details, items: items)
                    completionHandler(contents)
                } else if style.isEqual("热门") {
                    let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Bilibili.a")
                    let fileURL = groupURL?.appending(component: "HotResp")
                    let data = try Data(contentsOf: fileURL!)
                    let decode = try JSONDecoder().decode([HotResp].self, from: data)
                    let items = decode.map { $0.makeHotRespCarouselItem() }
                    let contents = TVTopShelfCarouselContent(style: .details, items: items)
                    completionHandler(contents)
                } else if style.isEqual("收藏") {
                    let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Bilibili.a")
                    let fileURL = groupURL?.appending(component: "Collect")
                    let data = try Data(contentsOf: fileURL!)
                    let decode = try JSONDecoder().decode([Collect].self, from: data)
                    let items = decode.map { $0.makeCollectRespCarouselItem() }
                    let contents = TVTopShelfCarouselContent(style: .details, items: items)
                    completionHandler(contents)
                } else if style.isEqual("推荐") {
                    let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Bilibili.a")
                    let fileURL = groupURL?.appending(component: "FeedResp")
                    let data = try Data(contentsOf: fileURL!)
                    let decode = try JSONDecoder().decode([FeedResp].self, from: data)
                    let items = decode.map { $0.makeFeedRespCarouselItem() }
                    let contents = TVTopShelfCarouselContent(style: .details, items: items)
                    completionHandler(contents)
                } else {
                    completionHandler(nil)
                }

            } catch {}
        }
    }
}
