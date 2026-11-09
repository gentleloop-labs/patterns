import PatternsCore
import SwiftUI

/// The result of a live database query, as Riverpod's `AsyncValue`.
enum Loadable<Value> {
    case loading
    case loaded(Value)
    case failed

    var value: Value? {
        if case let .loaded(value) = self { return value }
        return nil
    }
}

extension View {
    /// Keeps `value` up to date with a query. GRDB re-runs it after every
    /// write to the tables it reads, including restores and wipes, so
    /// screens never show stale rows.
    func liveQuery<Value: Sendable>(
        _ database: PatternsDatabase,
        into value: Binding<Loadable<Value>>,
        fetch: @escaping @Sendable (Database) throws -> Value
    ) -> some View {
        task {
            do {
                for try await rows in ValueObservation.tracking(fetch).values(in: database.queue) {
                    value.wrappedValue = .loaded(rows)
                }
            } catch is CancellationError {
            } catch {
                value.wrappedValue = .failed
            }
        }
    }
}
