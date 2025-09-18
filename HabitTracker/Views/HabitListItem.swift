// Views/HabitListItem.swift

import SwiftUI

struct HabitListItem: View {
    var habit: Habit // instancia de Habit, solo muestra los datos que recibe
    
    var body: some View {
        HStack(spacing: 16) {
            
            
            Image(systemName: habit.iconName) //muestra el ícono del hábito
                .font(.title2)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) { //columna, texto a la izquierda
                Text(habit.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .lineLimit(1) //el texto no ocupa más de una línea
                
                if !habit.description.isEmpty { //si la descripcion del hábito no esta vacia, muestra la descripcion
                    Text(habit.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            if habit.isFavorite { // muestra el icono de estrella si la propiedad isFavorite es true
                Image(systemName: "star.fill") //estrella llena de SF Symbols
                    .foregroundColor(.yellow)
                    .font(.title2)
                    .symbolEffect(.bounce, value: habit.isFavorite) //animación
                    .padding(.trailing, 4)
            }
        }
        .habitStyle() //modifier que aplica todo de una sola llamada
    }
}
