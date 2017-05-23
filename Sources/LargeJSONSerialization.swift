import Foundation

extension Large {
    init?(_ d: [String: Any]??) {
        guard
            let programList = d??["ProgramList"] as? [String: Any],
            let programs = programList["Programs"] as? [[String: Any]]
            else {
                return nil
        }
        var newPrograms = [Program]()
        for program in programs {
            guard let newProgram = Program(program) else {
                return nil
            }
            newPrograms.append(newProgram)
        }
        self.programList = ProgramList(programs: newPrograms)
    }
}

extension Program {
    init?(_ d: [String: Any]) {
        guard
            let title = d["Title"] as? String,
            let channel = d["Channel"] as? [String: Any],
            let chanId = channel["ChanId"] as? String,
            let recordingDict = d["Recording"] as? [String: Any],
            let recording = Recording(recordingDict)
            else {
                return nil
        }
        self.title = title
        self.chanId = chanId
        self.recording = recording

        description = d["Description"] as? String ?? nil
        subtitle = d["SubTitle"] as? String ?? nil
        season = Int(d["Season"] as? String ?? "")
        episode = Int(d["Episode"] as? String ?? "")
    }
}

extension Recording {
    init?(_ d: [String: Any]) {
        guard
            let startTs = d["StartTs"] as? String,
            let recordId = d["RecordId"] as? String
            else {
                return nil
        }
        self.startTs = startTs
        self.recordId = recordId

        if  let statusStr = d["Status"] as? String,
            let status = Status(rawValue: statusStr) {
            self.status = status
        } else {
            status = .Unknown
        }

        if  let recGroupStr = d["RecGroup"] as? String,
            let recGroup = RecGroup(rawValue: recGroupStr) {
            self.recGroup = recGroup
        } else {
            recGroup = .Unknown
        }
    }
}
