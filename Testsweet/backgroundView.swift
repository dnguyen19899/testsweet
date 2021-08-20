//
//  backgroundView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/16/21.
//

import SwiftUI

struct backgroundView: View {
    
    @State private var isAnimating = false
 
    @EnvironmentObject var theme : Themes
    
    func getNumberOfRows() -> Int{
        let heightPerItem = UIScreen.main.bounds.width/CGFloat(self.itemsPerRow)
        return Int(UIScreen.main.bounds.height/heightPerItem)+1
    }
    
    func getIcon() -> String{
        let iconsQuestions = ["airplane","car","bus.doubledecker","hare.fill", "tortoise.fill", "umbrella.fill", "ant", "leaf.fill", "face.smiling", "paperplane.fill", "bicycle", "figure.walk", "tram.fill"]
        let randomIndex = Int.random(in: 0...12)
        return iconsQuestions[randomIndex]
    }
     
    func getColor() -> Color{
        let colors = theme.getArray()
        let randNum = Int.random(in: 0...colors.count-1)
        return colors[randNum]
    }
    var itemsPerRow = 6
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                ForEach(0..<getNumberOfRows()){_ in
                    HStack(spacing:0){
                        ForEach(0..<self.itemsPerRow){_ in
                            Image(systemName: getIcon())
                                .font(.system(size: 30))
                                .foregroundColor(getColor())
                                .frame(width: UIScreen.main.bounds.width/CGFloat(self.itemsPerRow), height: UIScreen.main.bounds.width/CGFloat(self.itemsPerRow))
                                .opacity(0.2)
                                .animation(
                                    Animation
                                        .linear(duration:Double.random(in:2.0...5.0))
                                        .repeatForever(autoreverses: true)
                                        .delay(Double.random(in: 0...1.5))
                                )
                        }
                    }
                }
            }
        }
    }
}

/*
struct backgroundView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundView(currentTheme: )
    }
}
 */
