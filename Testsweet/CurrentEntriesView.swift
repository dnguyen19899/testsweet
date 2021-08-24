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
                if show {
                    
                    // theme.getAccent3().opacity(0.3).edgesIgnoringSafeArea(.all)
                    Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                    Section{
                    VStack{
                        Text("Current Entires")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45, alignment: .center)
                            .font(Font.system(size: 30, weight: .semibold))
                            .foregroundColor(Color.white)
                            .background(theme.getPrimanry())
                        List {
                            ForEach(NewCurrentEntries, id: \.self){ entry in
                                Text(entry.toString())
                            }
                        }
                        .frame(height: 450)
                        
                        Button(action: {
                            withAnimation{
                                show = false
                            }
                        }, label: {
                            Text("OK")
                                .frame(maxWidth: .infinity)
                                .frame(height: 54, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(theme.getSecondary())
                                .font(Font.system(size: 30, weight: .semibold))
                        }).buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                       .overlay(
                        RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                    //.border(Color.white, width: 2)
                    .background(Color(.white))
                    .cornerRadius(25)
                    }.transition(.moveAndFade)
                }
            }
    }
}


