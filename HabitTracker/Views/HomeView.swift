import SwiftUI

struct HomeView: View {
    @State private var habits: [Habit] = [
        Habit(name: "Hacer ejercicio", description: "Ejercicio diario por 30 minutos", iconName: "figure.walk", isFavorite: false),
        Habit(name: "Leer", description: "Leer 20 páginas por día", iconName: "book.fill", isFavorite: false),
        Habit(name: "Meditar", description: "Meditar 10 minutos", iconName: "leaf.fill", isFavorite: true),
        Habit(name: "Aprender Swift", description: "Estudiar 30 minutos al día", iconName: "swift", isFavorite: true),
        Habit(name: "Beber agua", description: "Beber 2 litros de agua", iconName: "drop.fill", isFavorite: false),
        Habit(name: "Comer lunch", description: "Desaynar frutilupis", iconName: "fork.knife", isFavorite: true),
        Habit(name: "Ir al Gym", description: "Hacer 1 hora de GYM", iconName: "dumbbell.fill", isFavorite: false),
        Habit(name: "Ir a clase", description: "Evitar volarme mi clase", iconName: "graduationcap.fill", isFavorite: false)
    ]
    
    @State private var searchText = ""
    @State private var sortAscending = true
    @State private var showingNewHabitSheet = false
    @State private var showingEditSheet = false
    @State private var habitToEdit: Habit?
    
    var sortedAndFilteredHabits: [Habit] {
        let filtered = habits.filter {
            searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
        }
        
        let favoriteHabits = filtered.filter { $0.isFavorite }
        let nonFavoriteHabits = filtered.filter { !$0.isFavorite }
        
        let sortedFavorites = favoriteHabits.sorted { sortAscending ? $0.name < $1.name : $0.name > $1.name }
        let sortedNonFavorites = nonFavoriteHabits.sorted { sortAscending ? $0.name < $1.name : $0.name > $1.name }
        
        return sortedFavorites + sortedNonFavorites
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if habits.isEmpty {
                    VStack(spacing: 16) {
                        Text("No tienes hábitos. ¡Crea uno!")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Button("Crear nuevo hábito") {
                            showingNewHabitSheet = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(sortedAndFilteredHabits) { habit in
                            if let index = habits.firstIndex(of: habit) {
                                NavigationLink {
                                    DetailView(habit: $habits[index], onEdit: { habitToEdit in
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
                        .onDelete(perform: deleteHabit)
                    }
                    .listStyle(.plain)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Buscar hábitos")
                }
                
                // Floating Action Button
                Button {
                    showingNewHabitSheet = true
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            sortAscending.toggle()
                        }
                    }) {
                        Image(systemName: sortAscending ? "arrow.up.arrow.down.circle.fill" : "arrow.down.arrow.up.circle.fill")
                            .symbolEffect(.bounce, value: sortAscending)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink("Modo enfoque") {
                        FocusView()
                    }
                    .tint(.gray)
                }
            }
            .sheet(isPresented: $showingNewHabitSheet) {
                EditView(habit: nil, onSave: saveHabit)
            }
            .sheet(isPresented: $showingEditSheet) {
                if let habit = self.habitToEdit {
                    EditView(habit: habit) { updatedHabit in
                        self.updateHabit(updatedHabit: updatedHabit)
                        self.habitToEdit = nil
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func saveHabit(newHabit: Habit) {
        habits.append(newHabit)
    }
    
    func updateHabit(updatedHabit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == updatedHabit.id }) {
            habits[index] = updatedHabit
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        let habitsToDelete = offsets.map { self.sortedAndFilteredHabits[$0] }
        for habit in habitsToDelete {
            if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                habits.remove(at: index)
            }
        }
    }
}
