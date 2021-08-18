//
//  backgroundView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/16/21.
//

import SwiftUI

struct backgroundView: View {
    
    @State private var isAnimating = false
    
    func getNumberOfRows() -> Int{
        let heightPerItem = UIScreen.main.bounds.width/CGFloat(self.itemsPerRow)
        return Int(UIScreen.main.bounds.height/heightPerItem)+1
    }
    
    func getIcon() -> String{
        let iconsQuestions = ["airplane","car","bus.doubledecker","hare.fill", "tortoise.fill", "umbrella.fill", "ant", "leaf.fill", "face.smiling", "paperplane.fill", "bicycle", "figure.walk", "tram.fill"]
        let randomIndex = Int.random(in: 0...12)
        return iconsQuestions[randomIndex]
    }
     
    func getColor() -> UIColor{
        let colors = [(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)), (#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1)), (#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1))]
        let randNum = Int.random(in: 0...9)
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
                                .foregroundColor(Color(getColor()))
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

struct backgroundView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundView()
    }
}
