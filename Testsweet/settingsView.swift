//
//  settingsUIView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/20/21.
//

import SwiftUI


struct settingsView: View {
    
    

    @EnvironmentObject var theme: Themes
    
    var body: some View {
        ZStack{
            
            VStack{
                Text("Choose a Theme")
                VStack{
                    Button(action: {
                        
                        print("green Theme")
                        theme.currentTheme = 1
                        print(theme.currentTheme)
                    }, label: {
                        Text("Green Theme")
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(
                            LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                        )
                    .cornerRadius(10)
                    Button(action: {
                        print("purple Theme")
                        theme.currentTheme = 2
                        print(theme.currentTheme)
                    }, label: {
                        Text("purple Theme")
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(
                            LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.3673185706, green: 0.001331765903, blue: 0.8576361537, alpha: 1)),Color(#colorLiteral(red: 0.5308707952, green: 0, blue: 0.938947022, alpha: 1)),Color(#colorLiteral(red: 0.6310049295, green: 0, blue: 0.9488027692, alpha: 1)),Color(#colorLiteral(red: 0.6931573749, green: 0, blue: 0.909084022, alpha: 1)),Color(#colorLiteral(red: 0.8202272058, green: 0.02823127806, blue: 0.820595026, alpha: 1)),Color(#colorLiteral(red: 0.8591464162, green: 0.05205651373, blue: 0.7118347287, alpha: 1)),Color(#colorLiteral(red: 0.8968603015, green: 0.06601992249, blue: 0.6419138312, alpha: 1)),Color(#colorLiteral(red: 0.9508308768, green: 0.0824488923, blue: 0.5370048881, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                        )
                    .cornerRadius(10)
                    Button(action: {
                        print("cozy Theme")
                        theme.currentTheme = 3
                        print(theme.currentTheme)
                    }, label: {
                        Text("cozy Theme")
                    })
                    .padding()
                    .foregroundColor(.white)
                    .background(
                            LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.5884678364, green: 0.4203606844, blue: 0.6142408252, alpha: 1)),Color(#colorLiteral(red: 0.7894214988, green: 0.526325345, blue: 0.525459826, alpha: 1)),Color(#colorLiteral(red: 0.9488562942, green: 0.7211748958, blue: 0.5038855672, alpha: 1)),Color(#colorLiteral(red: 0.9050268531, green: 0.8116474152, blue: 0.7356891036, alpha: 1)),Color(#colorLiteral(red: 0.2171717172, green: 0.2092127124, blue: 0.2028890489, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                        )
                    .cornerRadius(10)
                }
            }
            
            
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarColor(UIColor(theme.getPrimanry()))
        .background(backgroundView())
    }
    
}

/*
struct settingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView()
    }
}
 */
