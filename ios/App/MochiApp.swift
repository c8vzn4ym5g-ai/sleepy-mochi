import SwiftUI

@main
struct MochiApp: App {
    var body: some Scene {
        WindowGroup {
            #if PREVIEW_ONLY
            PetView()
            #else
            CompanionHome()
            #endif
        }
    }
}

struct PetView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var pose = 0
    private let images = ["real-awake", "real-yawn", "real-sleep"]
    var body: some View {
        GeometryReader { space in
            ZStack {
                Color(red: 0.96, green: 0.94, blue: 0.90).ignoresSafeArea()
                VStack(spacing: 12) {
                    Spacer()
                    ZStack {
                        ForEach(0..<3) { index in
                            Image(images[index]).resizable().scaledToFit()
                                .opacity(pose == index ? 1 : 0)
                        }
                    }
                    .frame(width: min(space.size.width * 0.94, 460), height: min(space.size.height * 0.54, 460))
                    Text("主人，陪我睡吧")
                        .font(.system(size: 19, weight: .regular, design: .rounded))
                        .foregroundStyle(Color(red: 0.45, green: 0.39, blue: 0.31))
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }
        .task(id: scenePhase) {
            guard scenePhase == .active else { return }
            for next in [1, 2] {
                do { try await Task.sleep(for: .seconds(4.5)) } catch { return }
                withAnimation(.easeInOut(duration: 1.2)) { pose = next }
            }
        }
    }
}
