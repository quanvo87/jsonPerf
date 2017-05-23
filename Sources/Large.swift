// https://github.com/bwhiteley/JSONShootout

import Foundation

// MARK: - Large

/*
 This `Large` struct must be implemented because the top-level object of the 
 JSON must conform to `Codable`.

 We must write our own implementation of the protocol because the keys in the
 JSON do not match the property names (the keys are capitalized),
 and because there are optional properties. Otherwise, we could let the compiler
 generate this for us.
 
 Implementing the decoding of `nil` to properties when a key was not found 
 (instead of throwing an error) decreased performance.
 */

struct Large {
    struct ProgramList {
        let programs: [Program]
    }

    let programList: ProgramList
}

extension Large: Codable {
    enum CodingKeys: CodingKey {
        case ProgramList
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(programList, forKey: .ProgramList)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        programList = try container.decode(ProgramList.self, forKey: .ProgramList)
    }
}

extension Large.ProgramList: Codable {
    enum CodingKeys: CodingKey {
        case Programs
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(programs, forKey: .Programs)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        programs = try container.decode([Program].self, forKey: .Programs)
    }
}

// MARK: - Program
struct Program {
    let title: String
    let description: String?
    let subtitle: String?
    let season: Int?
    let episode: Int?
    let chanId: String
    let recording: Recording
}

extension Program: Codable {
    enum CodingKeys: CodingKey {
        case Title
        case Description
        case SubTitle
        case Season
        case Episode
        case Channel
        case Recording
    }

    enum ChannelKeys: CodingKey {
        case ChanId
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .Title)
        try container.encode(recording, forKey: .Recording)

        var nested = container.nestedContainer(keyedBy: ChannelKeys.self, forKey: .Channel)
        try nested.encode(chanId, forKey: .ChanId)

        if let description = description {
            try container.encode(description, forKey: .Description)
        }
        if let subtitle = subtitle {
            try container.encode(subtitle, forKey: .SubTitle)
        }
        if let season = season {
            try container.encode(season, forKey: .Season)
        }
        if let episode = episode {
            try container.encode(episode, forKey: .Episode)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .Title)
        recording = try container.decode(Recording.self, forKey: .Recording)

        let nested = try container.nestedContainer(keyedBy: ChannelKeys.self, forKey: .Channel)
        chanId = try nested.decode(String.self, forKey: .ChanId)

        do {
            description = try container.decode(String.self, forKey: .Description)
        } catch {
            description = nil
        }

        do {
            subtitle = try container.decode(String.self, forKey: .SubTitle)
        } catch {
            subtitle = nil
        }

        do {
            season = try container.decode(Int.self, forKey: .Season)
        } catch {
            season = nil
        }

        do {
            episode = try container.decode(Int.self, forKey: .Episode)
        } catch {
            episode = nil
        }
    }
}

// MARK: - Recording
struct Recording {
    enum RecGroup: String, Codable {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }

    enum Status: String, Codable {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }

    let recordId: String
    let recGroup: RecGroup
    let startTs: String
    let status: Status
}

extension Recording: Codable {
    enum CodingKeys: CodingKey {
        case RecordId
        case RecGroup
        case StartTs
        case Status
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recordId, forKey: .RecordId)
        try container.encode(recGroup, forKey: .RecGroup)
        try container.encode(startTs, forKey: .StartTs)
        try container.encode(status, forKey: .Status)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recordId = try container.decode(String.self, forKey: .RecordId)
        startTs = try container.decode(String.self, forKey: .StartTs)

        do {
            recGroup = try container.decode(RecGroup.self, forKey: .RecGroup)
        } catch {
            recGroup = .Unknown
        }

        do {
            status = try container.decode(Status.self, forKey: .Status)
        } catch {
            status = .Unknown
        }
    }
}
