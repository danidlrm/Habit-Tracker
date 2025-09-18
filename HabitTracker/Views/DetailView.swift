// Views/DetailView.swift

import SwiftUI

struct DetailView: View {
    @Binding var habit: Habit //propiedad habit de tipo habit, enlace a la propiedad del hábito en la HomeView, cualquier cambio en DetailView se refleje automáticamente en HomeView
    var onEdit: (Habit) -> Void //clausura(funcion/argumento). onEdit toma un habit como parámetro y no devuelve nada, para que Homeview sepa cuando se quiere editar un hábito
    
    var body: some View { //cuerpo
        VStack(alignment: .leading, spacing: 20) { //vstack para columna, alineacion izq., espacio 20
            
            
            HStack { //para filas , tiene el nombre del habot y el botón de fav
                Text(habit.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) { //animacion 
                        habit.isFavorite.toggle() //isfavorite es true o false y @Binding pasa el cambio a HV
                    }
                }) {
                    Image(systemName: habit.isFavorite ? "star.fill" : "star") //look del botón como estrella, ?(condicion) si es true esta llena si es false es contorno
                        .font(.title2)
                        .foregroundColor(habit.isFavorite ? .yellow : .gray)
                        .scaleEffect(habit.isFavorite ? 1.2 : 1.0)
                }
            }
            .padding(.bottom, 10)
            
            
            Text(habit.description) //descripcion de habito
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding() //espacio al vstack
        .navigationTitle(habit.name) //titulo
        .navigationBarTitleDisplayMode(.inline) //titulo en chiquito
        .toolbar { //modifier para añadir elementos a la barra de herramientas
            ToolbarItem(placement: .topBarTrailing) { //coloca elembto en la derecha superior
                Button("Edit") {
                    onEdit(habit) //click llama a onEdit y pasa a habit entonces HV sabe que habito editar
                }
            }
        }
    }
}
