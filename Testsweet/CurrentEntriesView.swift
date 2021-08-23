//
//  CurrentEntriesView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/18/21.
//

import SwiftUI

struct CurrentEntriesView: View {
    
    @Binding var show: Bool
    
    @EnvironmentObject var theme : Themes
    
    private var NewCurrentEntries : Array<Entry>
    
    init(show: Binding<Bool>, currentEntries: Array<Entry>) {
        _show = show
        self.NewCurrentEntries = currentEntries
    }
    
    var body: some View {
            ZStack{
                theme.getAccent3().opacity(0.3).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Current Entires")
                        .font(.system(size: 30, weight: .heavy, design: .default))
                        .bold()
                        .padding()
                        .foregroundColor(Color(hex: 0x184e77))
                    List {
                        ForEach(NewCurrentEntries, id: \.self){ entry in
                            Text(entry.toString())
                        }
                    }
                    Button(action: {
                        show = false
                    }, label: {
                        Text("Dismiss")
                            .bold()
                            .font(Font.custom("Helvetica Neue", size: 20.0))
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                            .foregroundColor(Color.white)
                            .background(theme.getPrimanry())
                            .cornerRadius(12)
                    }).padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/2)
            .cornerRadius(12)
    }
}


