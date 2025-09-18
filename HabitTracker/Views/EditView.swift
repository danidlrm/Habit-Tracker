// Views/EditView.swift
import SwiftUI


struct EditView: View {
    @State private var habitName: String // guarda el texto del nombre y State define que se puede cambiar
    @State private var habitDescription: String
    @State private var habitIconName: String
    @State private var showingIconPicker = false //bool que controla la vista para seleccionar un ícono
    
    var habitToEdit: Habit? //opcional si se está editandp un habito o se crea uno nuevo
    var onSave: (Habit) -> Void //clausura para guardar
    @Environment(\.dismiss) var dismiss //enlace al entorno para cerrar sheet actual
    
    init(habit: Habit?, onSave: @escaping (Habit) -> Void) { //inicializador
        self.habitToEdit = habit //asigna el hábito a editar
        self.onSave = onSave //Asigna la clausura
        _habitName = State(initialValue: habit?.name ?? "") //inicializa HabitName, _habitDescription, _habitIconName y ?? verifica que existe si si usa name, etc; si no ""
        _habitDescription = State(initialValue: habit?.description ?? "")
        _habitIconName = State(initialValue: habit?.iconName ?? "figure.walk")
    }
    
    var body: some View {
        NavigationStack { //navegación
            Form { //contenedor
                Section(header: Text("Información del Hábito")) { //seccion con encabezado
                    TextField("Nombre del Hábito (ej. Meditar)", text: $habitName) //campo de texto que toma la entrada del usuario y hace enlace a habitName
                    TextField("Descripción (ej. 10 minutos por la mañana)", text: $habitDescription)
                    TextField("Nombre del icono (ej. 'book.fill')", text: $habitIconName)
                }
                
                Section(header: Text("Ícono")) { //seccion dentro del form
                    Button(action: { //boton True del icono
                        self.showingIconPicker = true
                    }) {
                        HStack { //fila
                            Text("Seleccionar Ícono")
                                .foregroundColor(.primary)
                            Spacer() //a la derecha
                            Image(systemName: habitIconName)
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
            }
            .navigationTitle(habitToEdit == nil ? "Nuevo Hábito" : "Editar Hábito") //titulo de nav bar que decide si es nuevo o para ditar
            .toolbar { //botones a la barra de herramientas
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newHabit = Habit( //crea una nueva instancia de Habit
                            id: habitToEdit?.id ?? UUID(), //si existe un hábito para editar, usa su id para que el hábito se actualice. Si no, usa un nuevo
                            name: habitName,
                            description: habitDescription,
                            iconName: habitIconName,
                            isFavorite: habitToEdit?.isFavorite ?? false
                        )
                        onSave(newHabit)
                        dismiss()
                    }
                    .disabled(habitName.isEmpty) //deshabilita el botón si el habitName esta vacio
                }
            }
            .sheet(isPresented: $showingIconPicker) { //modifier
                IconPickerView(selectedIcon: $habitIconName) //crea una instancia de IconPickerView y elance a habitIconName
            }
        }
    }
}
