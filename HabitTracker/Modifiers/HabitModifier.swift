// Modifiers/HabitModifier.swift

import SwiftUI //aquí si imprtamos SwiftUI porque usamos ViewModifier y otras propiedades de la interfaz

struct HabitModifier: ViewModifier { //structura HabitModifier & ViewModifier es protocolo de SwiftUI que permite crear un modificador de vista reutilizable, encapsula modificadores en un solo objeto para aplicarlos a vistas
    func body(content: Content) -> some View { //funcion principal de ViewModifier, content es la vista a la que se le aplica el modificador. Some View - la funcion devuelve una vista
        content //se aplica a content
            .padding(16) //espacio de 16 puntos alrededor
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground))) //forma rectangular con esquinas redondeadas, radio 12 y color automatico para dark o light mode
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 0.5)) //capa encima del fondo pero atrás del conetnidp & .stroke es borde gris
            .shadow(color: Color.primary.opacity(0.1), radius: 8, x: 0, y: 4) //sombra a la vista, radio 8 hacia y
    }
}

extension View { //cualquier vista tiene acceso a la funcion
    func habitStyle() -> some View { //hace chiquito .modifier(HabitModifier()) -> .habitStyle()
        self.modifier(HabitModifier()) //aplica HabitModifier a self
    }
}


//modificador: propiedad que se puede aplicar a una vista para cambiar su apariencia o comportamiento.
