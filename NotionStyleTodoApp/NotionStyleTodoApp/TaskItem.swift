import Foundation
import SwiftData

@Model
final class TaskItem {
    var id: UUID
    var text: String
    var isCompleted: Bool
    var dueDate: Date?
    var createdAt: Date
    var updatedAt: Date

    init(text: String) {
        let now = Date()
        self.id = UUID()
        self.text = text
        self.isCompleted = false
        self.dueDate = nil
        self.createdAt = now
        self.updatedAt = now
    }
}
