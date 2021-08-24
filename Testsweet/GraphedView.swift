//
//  GraphedView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/18/21.
//

import SwiftUI



struct GraphedView: View {
    
    @State private var showGraphed = false
    @State private var getArrayHere: [String] = ["Loading"]
    
    @EnvironmentObject var theme: Themes
    
    func populateGetArray(){
        let NSController = NightscoutController(date: Date())
        NSController.getEntryRequest{(data) in
            getArrayHere = data
        }
    }
    
    var body: some View {
        ZStack{
            if showGraphed{
                Color.white.ignoresSafeArea(.all)
                Section() {
                            ZStack{
                                VStack{
                                    Text("Here is what is Graphed")
                                        .font(.title)
                                        .padding()
                                    NavigationView {
                                        List {
                                            
                                            ForEach(getArrayHere, id: \.self){ entry in
                                                Text(entry)
                                                
                                                
                                            }
                                            
                                        }
                                        .onAppear(perform: populateGetArray)
                                        
                                        
                                    }
                                    Button(action: {
                                        
                                        populateGetArray()
                                        
                                    }){
                                        Text("REFRESH")
                                            .bold()
                                            .font(Font.custom("Helvetica Neue", size: 20.0))
                                            .padding(.top, 15)
                                            .padding(.bottom, 15)
                                            .padding(.leading, 30)
                                            .padding(.trailing, 30)
                                            .foregroundColor(Color.white)
                                            .background(theme.getAccent1())
                                            .cornerRadius(12)
                                    }.padding()
                                    
                                }
                            }
                        }.transition(.moveAndFade)
                }
            VStack{
                
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation{
                            showGraphed.toggle()
                        }
                    }, label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(theme.getAccent3())
                            .font(.title)
                    }).padding()
                    Spacer()
                }
            }
            
            }
        }
    }


struct GraphedView_Previews: PreviewProvider {
    static var previews: some View {
        GraphedView()
    }
}
