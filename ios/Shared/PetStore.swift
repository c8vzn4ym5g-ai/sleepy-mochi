import Foundation
import FamilyControls
import ManagedSettings
import OSLog

enum PetStore {
    static let suite = "group.com.sleepymochi.prototype"
    static let defaults = UserDefaults(suiteName: suite)!
    static let settings = ManagedSettingsStore(named: .init("mochi"))
    static let log = Logger(subsystem: "com.sleepymochi.prototype", category: "ShieldProbe")
    static var selection: FamilyActivitySelection {
        get {
            guard let data = defaults.data(forKey: "selection"),
                  let value = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) else {
                return FamilyActivitySelection()
            }
            return value
        }
        set { defaults.set(try? JSONEncoder().encode(newValue), forKey: "selection") }
    }
    static var pose: Int {
        get { defaults.integer(forKey: "pose") }
        set { defaults.set(newValue, forKey: "pose") }
    }
    static func apply() {
        log.info("apply requested pose=\(pose) timestamp=\(Date().timeIntervalSince1970)")
        settings.shield.applications = selection.applicationTokens
    }
    static func clear() {
        log.info("clear requested timestamp=\(Date().timeIntervalSince1970)")
        settings.clearAllSettings()
    }
}
