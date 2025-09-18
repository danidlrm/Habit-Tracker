// Views/EditView.swift
import SwiftUI


struct EditView: View {
    @State private var habitName: String
    @State private var habitDescription: String
    @State private var habitIconName: String
    @State private var showingIconPicker = false
    
    var habitToEdit: Habit?
    var onSave: (Habit) -> Void
    @Environment(\.dismiss) var dismiss
    
    init(habit: Habit?, onSave: @escaping (Habit) -> Void) {
        self.habitToEdit = habit
        self.onSave = onSave
        _habitName = State(initialValue: habit?.name ?? "")
        _habitDescription = State(initialValue: habit?.description ?? "")
        _habitIconName = State(initialValue: habit?.iconName ?? "figure.walk")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Información del Hábito")) {
                    TextField("Nombre del Hábito (ej. Meditar)", text: $habitName)
                    TextField("Descripción (ej. 10 minutos por la mañana)", text: $habitDescription)
                    TextField("Nombre del icono (ej. 'book.fill')", text: $habitIconName)
                }
                
                Section(header: Text("Ícono")) {
                    Button(action: {
                        self.showingIconPicker = true
                    }) {
                        HStack {
                            Text("Seleccionar Ícono")
                                .foregroundColor(.primary) // Ensure it looks like a button
                            Spacer()
                            Image(systemName: habitIconName)
                                .font(.title2)
                                .foregroundColor(.gray) // Use your desired color
                        }
                    }
                }
                
            }
            .navigationTitle(habitToEdit == nil ? "Nuevo Hábito" : "Editar Hábito")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newHabit = Habit(
                            id: habitToEdit?.id ?? UUID(),
                            name: habitName,
                            description: habitDescription,
                            iconName: habitIconName,
                            isFavorite: habitToEdit?.isFavorite ?? false
                        )
                        onSave(newHabit)
                        dismiss()
                    }
                    .disabled(habitName.isEmpty)
                }
            }
            .sheet(isPresented: $showingIconPicker) {
                IconPickerView(selectedIcon: $habitIconName)
            }
        }
    }
}
