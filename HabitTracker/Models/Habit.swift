// Models/Habit.swift
import Foundation

struct Habit: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var iconName: String
    var isFavorite: Bool
}
