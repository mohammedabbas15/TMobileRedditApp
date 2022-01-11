//
//  FeedResponse.swift
//  TMobileRedditApp
//
//  Created by Mohammed Abbas on 11/11/21.
//

import Foundation

// MARK: - RedditFeedResponse
struct RedditFeedResponse: Codable {
//    let kind: String
    let data: RedditFeedData
}

// MARK: - TemperaturesData
struct RedditFeedData: Codable {
    let after: String
    let dist: Int
    let modhash: String
    let children: [Child]

    enum CodingKeys: String, CodingKey {
        case after, dist, modhash
        case children
    }
}

// MARK: - Child
struct Child: Codable {
    let kind: Kind
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String
    let thumbnailWidth: Int?
    let score: Int
    let thumbnail: String
    let numComments: Int

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailWidth = "thumbnail_width"
        case score
        case thumbnail
        case numComments = "num_comments"
    }
}

// MARK: - AllAwarding
struct AllAwarding: Codable {
    let giverCoinReward: Int?
    let subredditID: String?
    let isNew: Bool
    let daysOfDripExtension, coinPrice: Int
    let id: String
    let pennyDonate: Int?
    let awardSubType: AwardSubType
    let coinReward: Int
    let iconURL: String
    let daysOfPremium: Int
    let tiersByRequiredAwardings: [String: TiersByRequiredAwarding]?
    let resizedIcons: [ResizedIcon]
    let iconWidth, staticIconWidth: Int
    let isEnabled: Bool
    let awardingsRequiredToGrantBenefits: Int?
    let allAwardingDescription: String
    let subredditCoinReward, count, staticIconHeight: Int
    let name: String
    let resizedStaticIcons: [ResizedIcon]
    let iconFormat: Format?
    let iconHeight: Int
    let pennyPrice: Int?
    let awardType: AwardType
    let staticIconURL: String

    enum CodingKeys: String, CodingKey {
        case giverCoinReward = "giver_coin_reward"
        case subredditID = "subreddit_id"
        case isNew = "is_new"
        case daysOfDripExtension = "days_of_drip_extension"
        case coinPrice = "coin_price"
        case id
        case pennyDonate = "penny_donate"
        case awardSubType = "award_sub_type"
        case coinReward = "coin_reward"
        case iconURL = "icon_url"
        case daysOfPremium = "days_of_premium"
        case tiersByRequiredAwardings = "tiers_by_required_awardings"
        case resizedIcons = "resized_icons"
        case iconWidth = "icon_width"
        case staticIconWidth = "static_icon_width"
        case isEnabled = "is_enabled"
        case awardingsRequiredToGrantBenefits = "awardings_required_to_grant_benefits"
        case allAwardingDescription = "description"
        case subredditCoinReward = "subreddit_coin_reward"
        case count
        case staticIconHeight = "static_icon_height"
        case name
        case resizedStaticIcons = "resized_static_icons"
        case iconFormat = "icon_format"
        case iconHeight = "icon_height"
        case pennyPrice = "penny_price"
        case awardType = "award_type"
        case staticIconURL = "static_icon_url"
    }
}

enum AwardSubType: String, Codable {
    case appreciation = "APPRECIATION"
    case community = "COMMUNITY"
    case global = "GLOBAL"
    case group = "GROUP"
    case premium = "PREMIUM"
}

enum AwardType: String, Codable {
    case community = "community"
    case global = "global"
}

enum Format: String, Codable {
    case apng = "APNG"
    case png = "PNG"
}

// MARK: - ResizedIcon
struct ResizedIcon: Codable {
    let url: String
    let width, height: Int
    let format: Format?
}

// MARK: - TiersByRequiredAwarding
struct TiersByRequiredAwarding: Codable {
    let resizedIcons: [ResizedIcon]
    let awardingsRequired: Int
    let staticIcon: ResizedIcon
    let resizedStaticIcons: [ResizedIcon]
    let icon: ResizedIcon

    enum CodingKeys: String, CodingKey {
        case resizedIcons = "resized_icons"
        case awardingsRequired = "awardings_required"
        case staticIcon = "static_icon"
        case resizedStaticIcons = "resized_static_icons"
        case icon
    }
}

// MARK: - FlairRichtext
struct FlairRichtext: Codable {
    let e: E
    let t, a: String?
    let u: String?
}

enum E: String, Codable {
    case emoji = "emoji"
    case text = "text"
}

enum FlairTextColor: String, Codable {
    case dark = "dark"
    case light = "light"
}

enum FlairType: String, Codable {
    case richtext = "richtext"
    case text = "text"
}

enum Edited: Codable {
    case bool(Bool)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        throw DecodingError.typeMismatch(Edited.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Edited"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GalleryData
struct GalleryData: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let mediaID: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case mediaID = "media_id"
        case id
    }
}

// MARK: - Gildings
struct Gildings: Codable {
    let gid1, gid2, gid3: Int?

    enum CodingKeys: String, CodingKey {
        case gid1 = "gid_1"
        case gid2 = "gid_2"
        case gid3 = "gid_3"
    }
}

// MARK: - Media
struct Media: Codable {
    let oembed: Oembed?
    let type: String?
    let redditVideo: RedditVideo?

    enum CodingKeys: String, CodingKey {
        case oembed, type
        case redditVideo = "reddit_video"
    }
}

// MARK: - Oembed
struct Oembed: Codable {
    let providerURL: String
    let url: String?
    let html, authorName: String
    let height: Int?
    let width: Int
    let version: String
    let authorURL: String
    let providerName: String
    let cacheAge: Int?
    let type: String
    let title: String?
    let thumbnailWidth: Int?
    let thumbnailURL: String?
    let thumbnailHeight: Int?

    enum CodingKeys: String, CodingKey {
        case providerURL = "provider_url"
        case url, html
        case authorName = "author_name"
        case height, width, version
        case authorURL = "author_url"
        case providerName = "provider_name"
        case cacheAge = "cache_age"
        case type, title
        case thumbnailWidth = "thumbnail_width"
        case thumbnailURL = "thumbnail_url"
        case thumbnailHeight = "thumbnail_height"
    }
}

// MARK: - RedditVideo
struct RedditVideo: Codable {
    let bitrateKbps: Int
    let fallbackURL: String
    let height, width: Int
    let scrubberMediaURL: String
    let dashURL: String
    let duration: Int
    let hlsURL: String
    let isGIF: Bool
    let transcodingStatus: String

    enum CodingKeys: String, CodingKey {
        case bitrateKbps = "bitrate_kbps"
        case fallbackURL = "fallback_url"
        case height, width
        case scrubberMediaURL = "scrubber_media_url"
        case dashURL = "dash_url"
        case duration
        case hlsURL = "hls_url"
        case isGIF = "is_gif"
        case transcodingStatus = "transcoding_status"
    }
}

// MARK: - MediaEmbed
struct MediaEmbed: Codable {
    let content: String?
    let width: Int?
    let scrolling: Bool?
    let height: Int?
    let mediaDomainURL: String?

    enum CodingKeys: String, CodingKey {
        case content, width, scrolling, height
        case mediaDomainURL = "media_domain_url"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let status, e, m: String
    let p: [S]
    let s: S
    let id: String
}

// MARK: - S
struct S: Codable {
    let y, x: Int
    let u: String
}

enum WhitelistStatus: String, Codable {
    case allAds = "all_ads"
    case promoAdultNsfw = "promo_adult_nsfw"
    case someAds = "some_ads"
}

enum PostHint: String, Codable {
    case hostedVideo = "hosted:video"
    case image = "image"
    case link = "link"
    case richVideo = "rich:video"
}

// MARK: - Preview
struct Preview: Codable {
    let images: [Image]
    let enabled: Bool
}

// MARK: - Image
struct Image: Codable {
    let source: ResizedIcon
    let resolutions: [ResizedIcon]
    let variants: Variants
    let id: String
}

// MARK: - Variants
struct Variants: Codable {
    let obfuscated, nsfw: Nsfw?
}

// MARK: - Nsfw
struct Nsfw: Codable {
    let source: ResizedIcon
    let resolutions: [ResizedIcon]
}

enum SubredditType: String, Codable {
    case subredditTypePublic = "public"
}

enum Kind: String, Codable {
    case t3 = "t3"
}



