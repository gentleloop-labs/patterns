/// Stable ids for the Y-BOCS-based self-check, from
/// `lib/content/ybocs_content.dart`. Copy is looked up by these ids, so
/// saved symptoms, themes and scores never change with the language.
public enum YbocsDimension: Sendable { case obsessions, compulsions }

public struct YbocsQuestion: Sendable, Hashable {
    public let id: String
    public let dimension: YbocsDimension
}

public struct YbocsCategory: Sendable, Hashable, Identifiable {
    public let id: String
    public let kind: YbocsDimension
    public let items: [String]
}

public enum YbocsContent {
    /// The ten severity questions, five per dimension, scored 0 to 4.
    public static let questions: [YbocsQuestion] = [
        .init(id: "o_time", dimension: .obsessions),
        .init(id: "o_interfere", dimension: .obsessions),
        .init(id: "o_distress", dimension: .obsessions),
        .init(id: "o_resist", dimension: .obsessions),
        .init(id: "o_control", dimension: .obsessions),
        .init(id: "c_time", dimension: .compulsions),
        .init(id: "c_interfere", dimension: .compulsions),
        .init(id: "c_distress", dimension: .compulsions),
        .init(id: "c_resist", dimension: .compulsions),
        .init(id: "c_control", dimension: .compulsions),
    ]

    public static let categories: [YbocsCategory] = [
        .init(id: "aggressive", kind: .obsessions,
              items: ["agg_harm_self", "agg_harm_others", "agg_violent", "agg_blurt", "agg_impulse", "agg_responsible"]),
        .init(id: "contamination", kind: .obsessions,
              items: ["con_dirt", "con_bodily", "con_chemicals", "con_ill", "con_spread", "con_sticky"]),
        .init(id: "sexual", kind: .obsessions, items: ["sex_forbidden", "sex_others", "sex_orientation", "sex_aggressive"]),
        .init(id: "hoarding_obs", kind: .obsessions, items: ["hoard_discard", "hoard_value"]),
        .init(id: "religious", kind: .obsessions, items: ["rel_sacrilege", "rel_rightwrong", "rel_punish"]),
        .init(id: "symmetry_obs", kind: .obsessions, items: ["sym_even", "sym_exact", "sym_incomplete"]),
        .init(id: "somatic", kind: .obsessions, items: ["som_illness", "som_body"]),
        .init(id: "misc_obs", kind: .obsessions, items: ["misc_know", "misc_saywrong", "misc_lucky", "misc_sounds", "misc_lose"]),
        .init(id: "washing", kind: .compulsions, items: ["wash_hands", "wash_shower", "wash_clean", "wash_avoid"]),
        .init(id: "checking", kind: .compulsions, items: ["chk_locks", "chk_harm", "chk_mistake", "chk_body"]),
        .init(id: "repeating", kind: .compulsions, items: ["rep_reread", "rep_routine", "rep_untilright"]),
        .init(id: "counting", kind: .compulsions, items: ["cnt_count", "cnt_numbers"]),
        .init(id: "ordering", kind: .compulsions, items: ["ord_arrange", "ord_align"]),
        .init(id: "misc_comp", kind: .compulsions, items: ["mc_mental", "mc_reassure", "mc_touch", "mc_lists", "mc_avoid"]),
    ]
}

extension YbocsSeverity {
    /// The Dart enum name, used to pick localized copy.
    public var wireName: String {
        switch self {
        case .subclinical: "subclinical"
        case .mild: "mild"
        case .moderate: "moderate"
        case .severe: "severe"
        case .extreme: "extreme"
        }
    }
}
