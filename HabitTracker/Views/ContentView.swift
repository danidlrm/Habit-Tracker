// Views/ContentView.swift

import SwiftUI

struct ContentView: View { //View: renderiza una interfaz
    var body: some View { //devuelve una vista que defina el contenido y el diseño de la vista
        HomeView() //crea una instancia de HomeView, la primera vista que quiero ver es HomeView
    }
}

#Preview { //prev sin compilar
    ContentView() //prev de HomeView
}
