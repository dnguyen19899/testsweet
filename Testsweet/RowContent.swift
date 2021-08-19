//
//  RowContent.swift
//  Testsweet
//
//  Created by Duy Nguyen on 8/19/21.
//

import SwiftUI

struct RowContent: View {
    
    let test: Test
    //let title : String
    // let index : Int
    @Binding var indices : [Test]
    
    
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
                    .background( LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1)),]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
                }
                .frame(width:260, height: 100)
            }
            
            GeometryReader {
                
                geometry in
                
                VStack {
                    
                    Button(action: {
                        
                        indices.append(test)
                        if let index = UserDefaults.standard.testsList.index(of: test) {
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
