//
//  Model.swift
//  NewXcode
//
//  Created by Luciano Nicolini on 12/10/2023.
//

import SwiftUI

struct Model: Identifiable {
    var id: UUID = .init()
    var text: String
    var textColor: Color
    var circuleColor: Color
    var bgColor: Color
    var circuleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
    
    
}

// sample intro model
var sampleIntros: [Model] = [
    .init(
        text: "Mensaje Nro 1",
        textColor: .color4,
        circuleColor: .color4,
        bgColor: .color1),
    
        .init(
            text: "Mensaje Nro 2",
            textColor: .color1,
            circuleColor: .color1,
            bgColor: .color2),
    
        .init(
            text: "Mensaje Nro 3",
            textColor: .color2,
            circuleColor: .color2,
            bgColor: .color3),
    
        .init(
            text: "Mensaje Nro 4",
            textColor: .color3,
            circuleColor: .color3,
            bgColor: .color4),

        .init(
            text: "Mensaje Nro 5",
            textColor: .color4,
            circuleColor: .color4,
            bgColor: .color1
        ),
]



