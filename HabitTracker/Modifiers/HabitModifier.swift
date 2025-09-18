// Modifiers/HabitModifier.swift

import SwiftUI

struct HabitModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 0.5))
            .shadow(color: Color.primary.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

extension View {
    func habitStyle() -> some View {
        self.modifier(HabitModifier())
    }
}
