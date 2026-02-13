import SwiftUI
import SwiftData

@main
struct NotionStyleTodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
}
