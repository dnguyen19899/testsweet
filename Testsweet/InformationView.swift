//
//  PopUpWindow.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/11/21.
//

import SwiftUI

struct InformationView: View {
    
    @Binding var show: Bool
    @Binding var showAdd: Bool
    @Binding var showDelete: Bool
    
    var CGMPoints: Int64
    
    @State private var isAnimating = false
    @State private var showProgress = false
    @State private var showGetScreen = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    @State private var message = "Be Sure your file is saved as a CSV file!"
    
    @State private var text1 = ""
    
    @State private var text2 = ""
    
    @State private var text3 = ""
    
    @State private var counter = 0
    
    
    func updateText(){
        
        if counter == 0{
            message = "Be Sure your file is saved as a CSV file!"
        }
        
        if counter == 1{
            
            text1 = "Here is the correct format to make your CSV file in Excel"
            
            text2 = "Use the first two cells in row 1 as header:\n SGV | Direction"
            
            text3 = "Then type in your readings in each correspoding cell underneath the header, forming two columns."
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 2{
            
            text1 = "Here is an Example of the CSV file"
            
            text2 = "SGV, Direction\n100, FLAT\n110, SINGLE_UP\n40, DOUBLE_DOWN"
            
            text3 = ""
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 3{
            
            text1 = "In Order to add a blank use a -1 in the first cell"
            
            text2 = "SGV, Direction\n100, FLAT\n-1\n40, DOUBLE_DOWN"
            
            text3 = ""
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 4{
            
            text1 = "How to import your file to your phone"
            
            text2 = "Step 1:"
            
            text3 = "Create the file to the proper specifications previously mentioned"
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 5{
            
            text1 = "How to import your file to your phone"
            
            text2 = "Step 2:"
            
            text3 = "Save file as a CSV in a folder you'll remeber"
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 6{
            
            text1 = "How to import your file to your phone"
            
            text2 = "Step 3:"
            
            text3 = "Email yourself a copy of that CSV file"
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 7{
            
            text1 = "How to import your file to your phone"
            
            text2 = "Step 4:"
            
            text3 = "Open that email on your phone and save it to the files app"
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
        if counter == 8{
            
            text1 = "How to import your file to your phone"
            
            text2 = "Finally:"
            
            text3 = "Click the open button and select that file\n chose a date then click CREATE"
            
            message = "\(text1)\n\(text2)\n\(text3)"
            
        }
        
    }
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Information")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(hex: 0x212529))
                    
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.black)
                    
                    HStack{
                        
                        Button(action: {
                            
                            print("go left")
                            
                            if counter != 0{
                                
                                counter -= 1
                                
                            }
                            
                            updateText()
                            
                        }, label: {
                            
                            if counter == 0{
                                
                                Image(systemName: "arrowshape.turn.up.left")
                                
                            }
                            
                            else{
                                
                                Image(systemName: "arrowshape.turn.up.left.fill")
                                
                            }
                            
                            
                            
                        }).padding()
                        
                        .foregroundColor(.black)
                        
                        
                        
                        Button(action: {
                            
                            print("go right")
                            
                            if counter != 8 {
                                
                                counter += 1
                                
                            }
                            
                            updateText()
                            
                        }, label: {
                            
                            if counter == 8{
                                
                                Image(systemName: "arrowshape.turn.up.right")
                                
                            }
                            
                            else{
                                
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                
                            }
                            
                            
                            
                        }).padding()
                        
                        .foregroundColor(.black)
                        
                        
                        
                    }
                    
                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }, label: {
                        Text("OK")
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color(hex: 0x212529))
                            .font(Font.system(size: 23, weight: .semibold))
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                   .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                //.border(Color.white, width: 2)
                .background(Color(.white))
                .cornerRadius(25)
            }
            if showAdd {
                
                Color.black.opacity(showAdd ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Adding CGM Entries")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(hex: 0x212529))
                    
                    //                    Rectangle()
                    //                        .fill(Color.white)
                    //                        .frame(width: 1000, height: 1000)
                    VStack{
                        Text("Adding \(CGMPoints) points")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 16, weight: .regular))
                            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                            .foregroundColor(Color.black)
                        Image(systemName: "arrow.2.circlepath")
                            .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                            .animation(self.isAnimating ? foreverAnimation : .default)
                            .onAppear { self.isAnimating = true }
                            .onDisappear { self.isAnimating = false }
                            .onAppear { self.showProgress = true }
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color(hex: 0x212529))
                            .font(Font.system(size: 23, weight: .semibold))
                    }
                }
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                   .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                //.border(Color.white, width: 2)
                .background(Color(.white))
                .cornerRadius(25)
            }
            if showDelete {
                
                Color.black.opacity(showDelete ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Delete")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(hex: 0x212529))
                    
                    //                    Rectangle()
                    //                        .fill(Color.white)
                    //                        .frame(width: 1000, height: 1000)
                    VStack{
                        Text("Deleting all entries")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 16, weight: .semibold))
                            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                            .foregroundColor(Color.black)
                        Image(systemName: "arrow.2.circlepath")
                            .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                            .animation(self.isAnimating ? foreverAnimation : .default)
                            .onAppear { self.isAnimating = true }
                            .onDisappear { self.isAnimating = false }
                            .onAppear { self.showProgress = true }
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color(hex: 0x212529))
                            .font(Font.system(size: 23, weight: .semibold))
                    }
                }
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                   .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                //.border(Color.white, width: 2)
                .background(Color(.white))
                .cornerRadius(25)
            }
        }
        
    }
}
