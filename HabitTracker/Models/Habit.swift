// Models/Habit.swift
import Foundation //usamos Fundation porque solo tenemos el modelo de datos y necesitamos saber como se ve en pantalla


//estructura habit
struct Habit: Identifiable, Equatable { //identifiable(cada instancia tiene una identidad única) & equatable(permite que dos instancias se puedan comparar para ver si son == )
    var id = UUID() //valor aleatorio de identificación
    var name: String
    var description: String
    var iconName: String //guarda el nombre de un ícono de SF Symbols
    var isFavorite: Bool
}
