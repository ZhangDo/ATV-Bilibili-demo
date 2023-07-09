//
//  Settings.swift
//  BilibiliLive
//
//  Created by whw on 2022/10/19.
//

import Foundation

enum FeedDisplayStyle: Codable, CaseIterable {
    case large
    case normal
    case sideBar

    var hideInSetting: Bool {
        self == .sideBar
    }
}

enum Settings {
    @UserDefaultCodable("Settings.displayStyle", defaultValue: .normal)
    static var displayStyle: FeedDisplayStyle

    @UserDefault("Settings.direatlyEnterVideo", defaultValue: false)
    static var direatlyEnterVideo: Bool

    @UserDefaultCodable("Settings.mediaQuality", defaultValue: .quality_1080p)
    static var mediaQuality: MediaQualityEnum

    @UserDefaultCodable("Settings.danmuArea", defaultValue: .style_75)
    static var danmuArea: DanmuArea

    @UserDefaultCodable("Settings.danmuSize", defaultValue: .size_36)
    static var danmuSize: DanmuSize

    @UserDefault("Settings.losslessAudio", defaultValue: false)
    static var losslessAudio: Bool

    @UserDefault("Settings.preferAvc", defaultValue: false)
    static var preferAvc: Bool

    @UserDefault("Settings.defaultDanmuStatus", defaultValue: true)
    static var defaultDanmuStatus: Bool

    @UserDefault("Settings.danmuMask", defaultValue: true)
    static var danmuMask: Bool

    @UserDefault("Settings.vnMask", defaultValue: false)
    static var vnMask: Bool

    @UserDefault("Settings.loadHighestVideoOnly", defaultValue: false)
    static var loadHighestVideoOnly: Bool

    @UserDefault("Settings.contentMatch", defaultValue: true)
    static var contentMatch: Bool

    @UserDefault("Settings.continuePlay", defaultValue: true)
    static var continuePlay: Bool

    @UserDefault("DLNA.uuid", defaultValue: "")
    static var uuid: String

    @UserDefault("DLNA.enable", defaultValue: true)
    static var enableDLNA: Bool

    @UserDefault("Settings.continouslyPlay", defaultValue: true)
    static var continouslyPlay: Bool

    @UserDefault("Settings.loopPlay", defaultValue: false)
    static var loopPlay: Bool

    @UserDefault("Settings.play.autoSkip", defaultValue: true)
    static var autoSkip: Bool

    @UserDefault("Settings.showRelatedVideoInCurrentVC", defaultValue: true)
    static var showRelatedVideoInCurrentVC: Bool

    @UserDefault("Settings.requestHotWithoutCookie", defaultValue: false)
    static var requestHotWithoutCookie: Bool

    @UserDefault("Settings.arealimit.unlock", defaultValue: false)
    static var areaLimitUnlock: Bool

    @UserDefault("Settings.arealimit.customServer", defaultValue: "")
    static var areaLimitCustomServer: String

    @UserDefaultCodable("Settings.topShelf", defaultValue: .feed)
    static var topShelf: TopShelfEnum
}

struct MediaQuality {
    var qn: Int
    var fnval: Int
}

enum DanmuArea: Codable, CaseIterable {
    case style_75
    case style_50
    case style_25
    case style_0
}

enum DanmuSize: String, Codable, CaseIterable {
    case size_25
    case size_31
    case size_36
    case size_42
    case size_48
    case size_57

    var title: String {
        return "\(Int(size)) pt"
    }

    var size: CGFloat {
        switch self {
        case .size_25:
            return 25
        case .size_31:
            return 31
        case .size_36:
            return 36
        case .size_42:
            return 42
        case .size_48:
            return 48
        case .size_57:
            return 57
        }
    }
}

extension DanmuArea {
    var title: String {
        switch self {
        case .style_75:
            return "3/4屏"
        case .style_50:
            return "半屏"
        case .style_25:
            return "1/4屏"
        case .style_0:
            return "不限制"
        }
    }

    var percent: CGFloat {
        switch self {
        case .style_75:
            return 0.75
        case .style_50:
            return 0.5
        case .style_25:
            return 0.25
        case .style_0:
            return 1
        }
    }
}

enum MediaQualityEnum: Codable, CaseIterable {
    case quality_1080p
    case quality_2160p
    case quality_hdr_dolby
}

enum TopShelfEnum: Codable, CaseIterable {
    case feed
    case hot
    case ranking
    case favorite
}

enum RankingEnum: Codable, CaseIterable {
    case animation
    case music
    case dance
    case game
    case knowledge
    case technology
    case sports
    case car
    case life
    case food
    case animal
    case dramatic
    case fashion
    case entertainment
    case film
    case documentary
    case movie
    case tvSeries
}

extension RankingEnum {
    var desp: String {
        switch self {
        case .animation:
            return "动画"
        case .music:
            return "音乐"
        case .dance:
            return "舞蹈"
        case .game:
            return "游戏"
        case .knowledge:
            return "知识"
        case .technology:
            return "科技"
        case .sports:
            return "运动"
        case .car:
            return "汽车"
        case .life:
            return "生活"
        case .food:
            return "美食"
        case .animal:
            return "动物圈"
        case .dramatic:
            return "鬼畜"
        case .fashion:
            return "时尚"
        case .entertainment:
            return "娱乐"
        case .film:
            return "影视"
        case .documentary:
            return "纪录片"
        case .movie:
            return "电影"
        case .tvSeries:
            return "电视剧"
        }
    }
}

extension TopShelfEnum {
    var desp: String {
        switch self {
        case .feed:
            return "推荐"
        case .hot:
            return "热门"
        case .ranking:
            return "排行榜"
        case .favorite:
            return "收藏"
        }
    }
}

extension MediaQualityEnum {
    var desp: String {
        switch self {
        case .quality_1080p:
            return "1080p"
        case .quality_2160p:
            return "4K"
        case .quality_hdr_dolby:
            return "杜比视界"
        }
    }

    var qn: Int {
        switch self {
        case .quality_1080p:
            return 116
        case .quality_2160p:
            return 120
        case .quality_hdr_dolby:
            return 126
        }
    }

    var fnval: Int {
        switch self {
        case .quality_1080p:
            return 16
        case .quality_2160p:
            return 144
        case .quality_hdr_dolby:
            return 976
        }
    }
}
