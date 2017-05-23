import SwiftyJSON

extension Large {
    init(json: JSON) {
        let programs = json["ProgramList"]["Programs"].array
        var newPrograms = [Program]()
        programs?.forEach { newPrograms.append(Program(json: $0)) }
        programList = ProgramList(programs: newPrograms)
    }
}

extension Program {
    init(json: JSON) {
        title = json["Title"].stringValue
        chanId = json["Channel"]["ChanId"].stringValue
        description = json["Description"].string
        subtitle = json["SubTitle"].string
        season = Int(json["Season"].string ?? "")
        episode = Int(json["Episode"].string ?? "")
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
