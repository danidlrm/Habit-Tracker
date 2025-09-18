// Views/HabitListItem.swift

import SwiftUI

struct HabitListItem: View {
    var habit: Habit
    
    var body: some View {
        HStack(spacing: 16) {
            
            
            Image(systemName: habit.iconName)
                .font(.title2)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                if !habit.description.isEmpty {
                    Text(habit.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            if habit.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.title2)
                    .symbolEffect(.bounce, value: habit.isFavorite)
                    .padding(.trailing, 4)
            }
        }
        .habitStyle()
    }
}
