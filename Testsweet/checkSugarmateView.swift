//
//  checkSugarmateView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/19/21.
//

import SwiftUI

struct checkSugarmateView: View {
    
    @State var expectedResult: String
    @State private var drawBubbles = false
    @State private var items = 10
    
    @Binding var show: Bool
    
    @EnvironmentObject var theme : Themes
    
    func getColor() -> Color{
        let colors = theme.getArray()
        let randInt = Int.random(in: 0...colors.count-1)
        return colors[randInt]
    }
    func getsize() -> Int{
        let randNum = Int.random(in: 50...100)
        return randNum
    }
    func movex() -> Int{
        let randMove = Int.random(in: -140...140)
        let xoffset = randMove
        return xoffset
    }
    func movey() -> Int{
        let randMove = Int.random(in: -240...240)
        let xoffset = randMove
        return xoffset
    }
   
    var body: some View {
        
        ZStack{
            Color(#colorLiteral(red: 0.129445374, green: 0.1432131827, blue: 0.1591491401, alpha: 1)).ignoresSafeArea(.all)
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.4)
                .foregroundColor(theme.getAccent3())

                ZStack{
                    ForEach(0..<self.items){_ in
                        Circle()
                            .fill(getColor())
                            .opacity(0.4)
                            .frame(width: CGFloat(getsize()))
                            .offset(x: drawBubbles ? CGFloat(movex()): CGFloat(movex()), y: drawBubbles ? CGFloat(movey()) : CGFloat(movey()))
                            .animation(
                                Animation
                                    .linear(duration:Double.random(in:2.0...5.0))
                                    .repeatForever(autoreverses: true)
                                    .delay(Double.random(in: 0...1.5))
                            )
                            
                        
                    
                }.frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.3)
            }
            
            VStack{
                Text("Success! Go Check Sugarmate for:")
                    .fontWeight(.bold)
                    .font(.title)
                    .frame(width: UIScreen.main.bounds.width/1.3, alignment: .center)
                    .padding(.bottom, 270)
                
                Text(expectedResult)
                    .font(.system(size: 20))
                    .padding(.top , -160)
                    .padding(50)
                
                Button(action: {
                    withAnimation{
                        show = false
                    }
                }, label: {
                    Text("Done")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 50)
                        .background(theme.getAccent2())
                        .cornerRadius(10)
                })
            }.onAppear(){
                drawBubbles = true
            }
            
        }.transition(.moveAndFade)
    }
}


//struct checkSugarmateView_Previews: PreviewProvider {
//    static var previews: some View {
        //checkSugarmateView(expectedResult: "this is the reslut", show: $true)
 //   }
//}
