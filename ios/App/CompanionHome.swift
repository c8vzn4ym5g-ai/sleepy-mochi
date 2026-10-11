import SwiftUI
import FamilyControls
import DeviceActivity

struct CompanionHome: View {
    @State private var selection = PetStore.selection
    @State private var picker = false
    @State private var ready = PetStore.defaults.bool(forKey: "configured")
    @State private var message = ""
    private let probe = ProcessInfo.processInfo.arguments.contains("--probe")
    var body: some View {
        ZStack(alignment: .bottom) {
            PetView()
            if !ready {
                VStack(spacing: 12) {
                    Text("只設定一次，讓糰子陪你少看一會兒 YouTube。")
                        .multilineTextAlignment(.center)
                    Button("讓糰子陪我") {
                        Task {
                            do {
                                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                                picker = true
                            } catch { message = "尚未取得螢幕使用時間授權：\(error.localizedDescription)" }
                        }
                    }.buttonStyle(.borderedProminent).tint(.brown)
                    Text(message).font(.footnote)
                }.padding(24).background(.regularMaterial)
            }
            if ready && probe {
                VStack {
                    Text("開發量測入口 · 不代表已通過真機測試").font(.caption)
                    HStack {
                        Button("阻擋") { PetStore.apply() }
                        Button("解除") { PetStore.clear() }
                        Button("下個姿勢") {
                            PetStore.pose = (PetStore.pose + 1) % 3
                            PetStore.apply()
                        }
                    }.buttonStyle(.bordered)
                    Text("換圖是否重新繪製、出現間隔，需由錄影與系統回呼比對。")
                        .font(.caption).multilineTextAlignment(.center)
                }.padding().background(.regularMaterial)
            }
        }
        .familyActivityPicker(isPresented: $picker, selection: $selection)
        .onChange(of: picker) { showing in
            if !showing && !selection.applicationTokens.isEmpty {
                PetStore.selection = selection
                do {
                    let schedule = DeviceActivitySchedule(
                        intervalStart: DateComponents(hour: 0, minute: 0),
                        intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true)
                    let event = DeviceActivityEvent(applications: selection.applicationTokens,
                                                   threshold: DateComponents(minute: 1))
                    try DeviceActivityCenter().startMonitoring(.init("mochi-daily"), during: schedule,
                                                              events: [.init("youtube-break"): event])
                    PetStore.defaults.set(true, forKey: "configured")
                    ready = true
                } catch { message = "尚未開始陪伴：\(error.localizedDescription)" }
            }
        }
    }
}
