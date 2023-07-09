//
//  HotViewController.swift
//  BilibiliLive
//
//  Created by yicheng on 2022/10/26.
//

import UIKit

class HotViewController: StandardVideoCollectionViewController<VideoDetail.Info> {
    override func request(page: Int) async throws -> [VideoDetail.Info] {
        let resp: [VideoDetail.Info] = try await WebRequest.requestHotVideo(page: page).list
        if let encode = try? JSONEncoder().encode(resp) {
            let collectURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Bilibili.a")
            let fileURL: URL
            if #available(tvOS 16.0, *) {
                fileURL = (collectURL?.appending(component: "HotResp"))!
            } else {
                // Fallback on earlier versions
                fileURL = (collectURL?.appendingPathComponent("HotResp", conformingTo: .data))!
            }
            try encode.write(to: fileURL)
        }
        return resp
    }
}

extension WebRequest {
    static func requestHotVideo(page: Int) async throws -> HotData {
        try await request(url: EndPoint.hot, parameters: ["pn": page, "ps": 40], noCookie: Settings.requestHotWithoutCookie)
    }
}

extension WebRequest.EndPoint {
    static let hot = "https://api.bilibili.com/x/web-interface/popular"
}

struct HotData: Codable {
    let no_more: Bool
    let list: [VideoDetail.Info]
}
