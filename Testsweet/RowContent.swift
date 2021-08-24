//
//  RowContent.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/19/21.
//

import SwiftUI

struct RowContent: View {
    
    let test: Test
    @Binding var indices : [Test]
    
    @EnvironmentObject var theme : Themes
    
    var body: some View {
        
        HStack {
            NavigationLink(destination: TestView(test: test)) {
                GeometryReader {
                    
                    geometry in
                    
                    VStack {
                        
                        Text(self.test.title)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            .foregroundColor(Color.white)
                            .padding(.trailing)
                        
                    }
                    .frame(width: 260, height: 75)
                    .background( LinearGradient(gradient: Gradient(colors: theme.getGradient()), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
                    .shadow(radius: 5)
                }
                .frame(width:260, height: 100)
            }
            
            GeometryReader {
                
                geometry in
                
                VStack {
                    
                    Button(action: {
                        
                        indices.append(test)
                        if let index = UserDefaults.standard.testsList.firstIndex(of: test) {
                            UserDefaults.standard.testsList.remove(at: index)
                        }
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.white)
                            
                    }
                }
                .frame(width: 60, height: 60)
                .background(Color.red)
                .cornerRadius(50)
                .shadow(radius: 5)
            }
            .frame(width: 60, height: 90)
        }
    }
}

//struct RowContent_Previews: PreviewProvider {
//    static var previews: some View {
//        RowContent(title: "Title", index: 1, indices: )
//    }
//}
