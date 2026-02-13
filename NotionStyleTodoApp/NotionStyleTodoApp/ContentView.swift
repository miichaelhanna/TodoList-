import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskItem]

    @State private var draftTaskText = ""

    init() {}

    var body: some View {
        ZStack {
            Theme.backgroundSecondary.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Your Tasks")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(Theme.textPrimary)
                    .padding(.top, 8)

                inputRow

                if sortedTasks.isEmpty {
                    Text("No tasks")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Theme.textPrimary.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                } else {
                    List {
                        ForEach(sortedTasks) { task in
                            TaskRow(
                                task: task,
                                onToggle: { toggleComplete(task) },
                                onCommitEdit: { newText in editTask(task: task, newText: newText) },
                                onAssignDueDate: { dueDate in assignDueDate(task: task, dueDate: dueDate) }
                            )
                            .listRowInsets(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteTask(task)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .accessibilityLabel("Delete task")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }

                Spacer(minLength: 0)
            }
            .padding(20)
            .frame(maxWidth: 700)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Theme.backgroundPrimary)
        }
    }

    private var sortedTasks: [TaskItem] {
        tasks.sorted { lhs, rhs in
            if lhs.isCompleted != rhs.isCompleted {
                return lhs.isCompleted == false
            }
            return lhs.createdAt < rhs.createdAt
        }
    }

    private var inputRow: some View {
        HStack(spacing: 10) {
            TextField("Type a task...", text: $draftTaskText)
                .textFieldStyle(.plain)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Theme.textPrimary)
                .submitLabel(.done)
                .onSubmit(addTaskFromDraft)

            Button(action: addTaskFromDraft) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(Theme.textPrimary.opacity(0.75))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Add task")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Theme.backgroundPrimary)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Theme.accentHover, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

    private func addTaskFromDraft() {
        let trimmed = draftTaskText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        modelContext.insert(TaskItem(text: trimmed))
        draftTaskText = ""
    }

    private func toggleComplete(_ task: TaskItem) {
        withAnimation(.easeInOut(duration: 0.2)) {
            task.isCompleted.toggle()
            task.updatedAt = Date()
        }
    }

    private func editTask(task: TaskItem, newText: String) {
        let trimmed = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard task.text != trimmed else { return }

        task.text = trimmed
        task.updatedAt = Date()
    }

    private func deleteTask(_ task: TaskItem) {
        modelContext.delete(task)
    }

    private func assignDueDate(task: TaskItem, dueDate: Date?) {
        task.dueDate = dueDate
        task.updatedAt = Date()
    }
}

private struct TaskRow: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onCommitEdit: (String) -> Void
    let onAssignDueDate: (Date?) -> Void

    @State private var isEditing = false
    @State private var editingText = ""
    @State private var isShowingDueDateEditor = false
    @State private var selectedDueDate = Date()
    @FocusState private var isEditingFieldFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Theme.textPrimary.opacity(task.isCompleted ? 0.45 : 0.7))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(task.isCompleted ? "Mark task incomplete" : "Mark task complete")

            if isEditing {
                TextField("Type a task...", text: $editingText)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Theme.textPrimary)
                    .textFieldStyle(.plain)
                    .submitLabel(.done)
                    .focused($isEditingFieldFocused)
                    .onSubmit(commitEdit)
                    .onChange(of: isEditingFieldFocused) { _, isFocused in
                        if !isFocused && isEditing {
                            commitEdit()
                        }
                    }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.text)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Theme.textPrimary)
                        .strikethrough(task.isCompleted)
                        .opacity(task.isCompleted ? 0.4 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            editingText = task.text
                            isEditing = true
                            isEditingFieldFocused = true
                        }

                    if let dueDate = task.dueDate {
                        Text("Due \(dueDate.formatted(date: .abbreviated, time: .shortened))")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Theme.textPrimary.opacity(0.55))
                    }
                }
            }

            Button {
                selectedDueDate = task.dueDate ?? Date()
                isShowingDueDateEditor = true
            } label: {
                Image(systemName: task.dueDate == nil ? "calendar.badge.plus" : "calendar")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Theme.textPrimary.opacity(0.65))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(task.dueDate == nil ? "Assign due date and time" : "Edit due date and time")
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(isEditing ? Theme.accentHover : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .sheet(isPresented: $isShowingDueDateEditor) {
            NavigationStack {
                VStack(spacing: 16) {
                    DatePicker(
                        "Due Date",
                        selection: $selectedDueDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()

                    Button("Clear Due Date", role: .destructive) {
                        onAssignDueDate(nil)
                        isShowingDueDateEditor = false
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .navigationTitle("Task Schedule")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            isShowingDueDateEditor = false
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            onAssignDueDate(selectedDueDate)
                            isShowingDueDateEditor = false
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
    }

    private func commitEdit() {
        let original = task.text
        let trimmed = editingText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !trimmed.isEmpty {
            onCommitEdit(trimmed)
        } else {
            editingText = original
        }

        isEditing = false
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
