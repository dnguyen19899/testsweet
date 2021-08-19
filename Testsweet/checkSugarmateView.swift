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
    
    func getColor() -> Color{
        let colors = [Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1))]
        let randInt = Int.random(in: 0...6)
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
            Color.white
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.3)
                .foregroundColor(Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)))

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
                    .padding(.bottom, 300)
                
                Text(expectedResult)
                    .font(.system(size: 20))
                    .padding(.top , -200)
                    .padding(50)
                
                Button(action: {
                    show = false
                    print("Done")
                }, label: {
                    Text("Done")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 50)
                        .background(Color(hex: 0x52b69a))
                        .cornerRadius(10)
                })
            }.onAppear(){
                drawBubbles = true
            }
            
        }
    }
}


//struct checkSugarmateView_Previews: PreviewProvider {
//    static var previews: some View {
        //checkSugarmateView(expectedResult: "this is the reslut", show: $true)
 //   }
//}
