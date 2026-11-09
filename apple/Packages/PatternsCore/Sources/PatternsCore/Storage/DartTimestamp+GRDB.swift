import GRDB

/// Stores a timestamp as its plain text, exactly as Flutter does. Without
/// this, GRDB would JSON-encode the Codable wrapper into the column.
extension DartTimestamp: DatabaseValueConvertible {
    public var databaseValue: DatabaseValue { raw.databaseValue }

    public static func fromDatabaseValue(_ dbValue: DatabaseValue) -> DartTimestamp? {
        String.fromDatabaseValue(dbValue).map(DartTimestamp.init(raw:))
    }
}
