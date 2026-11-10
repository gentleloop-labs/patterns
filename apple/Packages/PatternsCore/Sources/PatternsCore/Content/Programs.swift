/// Structured programs and OCD theme tracks, from
/// `lib/mobile/screens/structured_programs_screen.dart` and
/// `lib/content/ocd_tracks.dart`. Ids are stored in enrollments and task
/// progress, so they never change; copy is looked up by them.
public struct ProgramWeek: Sendable, Hashable {
    public let id: String
    public let tasks: [String]
}

public struct ErpProgram: Sendable, Hashable, Identifiable {
    /// The stored `program_id`.
    public let id: String
    /// Set for a theme track (`track_<trackId>`); nil for a general program.
    public let trackID: String?
    public let weeks: [ProgramWeek]
    /// For tracks: the self-check categories it relates to.
    public let ybocsCategoryIDs: [String]

    public var totalTasks: Int { weeks.reduce(0) { $0 + $1.tasks.count } }

    /// The key the copy is filed under.
    public var copyKey: String {
        if let trackID { return trackID == "just-right" ? "justRight" : trackID }
        switch id {
        case "delay-4wk": return "delay4wk"
        case "uncertainty-3wk": return "uncertainty3wk"
        default: return id
        }
    }

    /// `OcdTrack.matchesThemes`: a hint only, never used to hide anything.
    public func matches(themes: [String]) -> Bool {
        !ybocsCategoryIDs.isEmpty && themes.contains { ybocsCategoryIDs.contains($0) }
    }
}

public enum ProgramContent {
    private static func track(_ id: String, _ categories: [String], _ prefix: String) -> ErpProgram {
        ErpProgram(id: "track_\(id)", trackID: id,
                   weeks: (1...3).map { ProgramWeek(id: "\(prefix)\($0)", tasks: ["\(prefix)\($0)a", "\(prefix)\($0)b"]) },
                   ybocsCategoryIDs: categories)
    }

    /// `ocdTracks`, in catalogue order.
    public static let tracks: [ErpProgram] = [
        track("contamination", ["contamination", "washing"], "ct"),
        track("checking", ["checking", "counting"], "ck"),
        track("harm", ["aggressive", "sexual", "religious"], "hm"),
        track("relationship", [], "rl"),
        track("just-right", ["symmetry_obs", "ordering", "repeating"], "jr"),
    ]

    /// `erpPrograms`.
    public static let general: [ErpProgram] = [
        ErpProgram(id: "delay-4wk", trackID: nil, weeks: (1...4).map {
            ProgramWeek(id: "delayW\($0)", tasks: ["w\($0)a", "w\($0)b"])
        }, ybocsCategoryIDs: []),
        ErpProgram(id: "uncertainty-3wk", trackID: nil, weeks: (1...3).map {
            ProgramWeek(id: "uncertaintyW\($0)", tasks: ["u\($0)a", "u\($0)b"])
        }, ybocsCategoryIDs: []),
    ]

    public static func program(id: String) -> ErpProgram? {
        (tracks + general).first { $0.id == id }
    }
}
