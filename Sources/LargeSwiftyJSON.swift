import SwiftyJSON

extension Large {
    init(json: JSON) {
        let programsArr = json["ProgramList"]["Programs"].array
        var newPrograms = [Program]()
        programsArr?.forEach { newPrograms.append(Program(json: $0)) }
        programList = ProgramList(programs: newPrograms)
    }
}

extension Program {
    init(json: JSON) {
        title = json["Title"].stringValue
        chanId = json["Channel"]["ChanId"].stringValue
        description = json["Description"].string
        subtitle = json["SubTitle"].string
        season = json["Season"].int
        episode = json["Episode"].int
        recording = Recording(json: json["Recording"])
    }
}

extension Recording {
    init(json: JSON) {
        startTs = json["StartTs"].stringValue
        recordId = json["RecordId"].stringValue
        if let raw = json["Status"].string {
            status = Status(rawValue: raw) ?? .Unknown
        } else {
            status = .Unknown
        }
        if let raw = json["RecGroup"].string {
            recGroup = RecGroup(rawValue: raw) ?? .Unknown
        } else {
            recGroup = .Unknown
        }
    }
}
