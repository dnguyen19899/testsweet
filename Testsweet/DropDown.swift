//
//  MenuBar.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/5/21.
//

import Foundation
import SwiftUI


struct DropdownButton: View {
    
    @State var shouldShowDropdown = false
    @Binding var displayText: String
    var options = [String]()
    
    @EnvironmentObject var theme : Themes
    
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    withAnimation{
                        shouldShowDropdown.toggle()
                    }
                    
                }, label: {
                    Text(displayText)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .rotationEffect(.degrees(shouldShowDropdown ? 90 : 0))
                        .scaleEffect(shouldShowDropdown ? 1.5 : 1)
                        .padding(.leading)

                })
                .padding([.leading, .trailing],45)
                .padding([.top,.bottom] , 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(theme.getPrimanry(), lineWidth: 5)
                )
                if shouldShowDropdown{
                    ZStack{
                        VStack(spacing: 5){
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "FLAT"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("FLAT")
                                    .foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "DOUBLE_UP"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("DOUBLE_UP").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "SINGLE_UP"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("SINGLE_UP").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "FORTY_FIVE_UP"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("FORTY_FIVE_UP").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "FORTY_FIVE_DOWN"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("FORTY_FIVE_DOWN").foregroundColor(.black)
                            })
                            Button(action: {
                               
                                withAnimation{
                                    displayText = "SINGLE_DOWN"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("SINGLE_DOWN").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "DOUBLE_DOWN"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("DOUBLE_DOWN").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "NOT_COMPUTABLE"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("NOT_COMPUTABLE").foregroundColor(.black)
                            })
                            Button(action: {
                                
                                withAnimation{
                                    displayText = "OUT_OF_RANGE"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("OUT_OF_RANGE").foregroundColor(.black)
                            })
                            Button(action: {
                                withAnimation{
                                    displayText = "None"
                                    shouldShowDropdown = false
                                }
                            }, label: {
                                Text("None").foregroundColor(.black)
                            })
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(theme.getPrimanry(), lineWidth: 5)
                    )
                    
                }
            }
        }
    }
}


