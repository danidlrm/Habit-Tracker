// Views/DetailView.swift

import SwiftUI

struct DetailView: View {
    @Binding var habit: Habit
    var onEdit: (Habit) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Header: Habit Name and Favorite Button
            HStack {
                Text(habit.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        habit.isFavorite.toggle()
                    }
                }) {
                    Image(systemName: habit.isFavorite ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundColor(habit.isFavorite ? .yellow : .gray)
                        .scaleEffect(habit.isFavorite ? 1.2 : 1.0)
                }
            }
            .padding(.bottom, 10)
            
            // Description
            Text(habit.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    onEdit(habit)
                }
            }
        }
    }
}
