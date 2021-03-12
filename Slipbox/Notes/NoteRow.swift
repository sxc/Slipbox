//
//  NoteRow.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/11.
//

import SwiftUI


struct NoteRow: View {
    
    let title: String
    let bodyText: String
    let creationDate: Date
    let isSelected: Bool
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(title)
                Spacer()
                Text(creationDate , formatter: itemFormatter)
                    .font(.footnote)
                
                    
            }
            
            Text(bodyText)
                .lineLimit(3)
                .font(.caption)
            
        }
        .padding(1)
        .background(RoundedRectangle(cornerRadius: 5).fill(isSelected ? selectedColor : unselectedColor))
        
            
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let bodyText = Note.defaultText
        
         return VStack(spacing: 5) {
            NoteRow(title: "note title", bodyText: bodyText, creationDate: Date(), isSelected: false)
            NoteRow(title: "note title", bodyText: "very short note", creationDate: Date(), isSelected: true)
            NoteRow(title: "note title", bodyText: bodyText, creationDate: Date(), isSelected: false)
        }.padding()
        .frame(width: 250)
    }
}
