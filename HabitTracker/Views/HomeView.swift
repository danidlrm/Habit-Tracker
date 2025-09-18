import SwiftUI

struct HomeView: View {
    @State private var habits: [Habit] = [ //arreglo de obj habit
        Habit(name: "Hacer ejercicio", description: "Ejercicio diario por 30 minutos", iconName: "figure.walk", isFavorite: false),
        Habit(name: "Leer", description: "Leer 20 páginas por día", iconName: "book.fill", isFavorite: false),
        Habit(name: "Meditar", description: "Meditar 10 minutos", iconName: "leaf.fill", isFavorite: true),
        Habit(name: "Aprender Swift", description: "Estudiar 30 minutos al día", iconName: "swift", isFavorite: true),
        Habit(name: "Beber agua", description: "Beber 2 litros de agua", iconName: "drop.fill", isFavorite: false),
        Habit(name: "Comer lunch", description: "Desaynar frutilupis", iconName: "fork.knife", isFavorite: true),
        Habit(name: "Ir al Gym", description: "Hacer 1 hora de GYM", iconName: "dumbbell.fill", isFavorite: false),
        Habit(name: "Ir a clase", description: "Evitar volarme mi clase", iconName: "graduationcap.fill", isFavorite: false)
    ]
    
    @State private var searchText = "" //guarda el texto del usuario
    @State private var sortAscending = true //bool para la lista ascendente o descendente
    @State private var showingNewHabitSheet = false // visibilidad de la hoja para crear un nuevo hábito
    @State private var showingEditSheet = false //visibilidad de la hoja para editar un hábito
    @State private var habitToEdit: Habit? //almacena el hábito que se va a editar
    
    var sortedAndFilteredHabits: [Habit] { //propiedad que genera un valor cada que se accede a ella
        let filtered = habits.filter { //filtra la lista de search
            searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) //Si el campo de búsqueda está vacio, muestra todos los hábitos
        }
        
        let favoriteHabits = filtered.filter { $0.isFavorite } //nuevo array con las fav habits
        let nonFavoriteHabits = filtered.filter { !$0.isFavorite } //nuevo array con el resto
        
        let sortedFavorites = favoriteHabits.sorted { sortAscending ? $0.name < $1.name : $0.name > $1.name } //ordena favs alfabeticamente
        let sortedNonFavorites = nonFavoriteHabits.sorted { sortAscending ? $0.name < $1.name : $0.name > $1.name } //ordena no favs
        
        return sortedFavorites + sortedNonFavorites //array con los favs al principio y el resto después ordenados
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) { //superpone vistas (el botón)
                if habits.isEmpty {
                    VStack(spacing: 16) {
                        Text("No tienes hábitos. ¡Crea uno!") //si el arreglo de habits está vacío.
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Button("Crear nuevo hábito") {
                            showingNewHabitSheet = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else { //Si el arreglo no está vacío, muestra la lista de hábitos
                    List {
                        ForEach(sortedAndFilteredHabits) { habit in //itera sobre el arreglo de hábitos
                            if let index = habits.firstIndex(of: habit) { //busca el índice del hábito en el arreglo original para editar
                                NavigationLink { //enlace a DetailView cuando se toca un elemnto
                                    DetailView(habit: $habits[index], onEdit: { habitToEdit in  //los cambios se guarden y clausura
                                        self.habitToEdit = habitToEdit
                                        self.showingEditSheet = true
                                    })
                                } label: {
                                    HabitListItem(habit: habit)
                                        .listRowSeparator(.hidden)
                                        .listRowBackground(Color.clear)
                                }
                            }
                        }
                        .onDelete(perform: deleteHabit) // deslizar una celda para eliminar un hábito
                    }
                    .listStyle(.plain)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar hábitos") //barra de búsqueda
                }
                
                //boton nuevo hábito
                Button {
                    showingNewHabitSheet = true //muestra el sheet si es true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray, in: Circle())
                        .shadow(color: Color.primary.opacity(0.3), radius: 6)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Hábitos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { //boton para ordenar hábitos en top derecha
                    Button(action: {
                        withAnimation {
                            sortAscending.toggle()
                        }
                    }) {
                        Image(systemName: sortAscending ? "arrow.up.arrow.down.circle.fill" : "arrow.down.arrow.up.circle.fill")
                            .symbolEffect(.bounce, value: sortAscending)
                    }
                }
                ToolbarItem(placement: .bottomBar) { //boton enfoque en bottom
                    NavigationLink("Modo enfoque") {
                        FocusView()
                    }
                    .tint(.gray)
                }
            }
            .sheet(item: $habitToEdit) { habit in //modifier del sheet que enseña la hoja cuando item no es nil, enlace a habitToEdit
                EditView(habit: habit) { updatedHabit in //la vista no se inicializa con un valor nil, evita que aparezca en blanco
                    self.updateHabit(updatedHabit: updatedHabit)
                }
            }
            .sheet(isPresented: $showingNewHabitSheet) { //modifier true o false, enlace a nuevo hábito
                EditView(habit: nil, onSave: saveHabit) //instancia de EditView
            }
        }
    }
    
    // MARK: - Funciones ayuda
    
    func saveHabit(newHabit: Habit) { //agregar un nuevo hábito al arreglo
        habits.append(newHabit)
    }
    
    func updateHabit(updatedHabit: Habit) { //busca habito por id y lo actualiza en el array
        if let index = habits.firstIndex(where: { $0.id == updatedHabit.id }) {
            habits[index] = updatedHabit
        }
    }
    
    func deleteHabit(at offsets: IndexSet) { //elimina un hábito de la lista, IndexSet: indices de los elemntos que se van a eliminar
        let habitsToDelete = offsets.map { self.sortedAndFilteredHabits[$0] }
        for habit in habitsToDelete {
            if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                habits.remove(at: index)
            }
        }
    }
}
