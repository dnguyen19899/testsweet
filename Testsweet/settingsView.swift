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
                    .bold()
                    .font(Font.custom("Helvetica Neue", size: 30.0))
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .foregroundColor(Color.black)
                                    
                
                VStack{
                    Button(action: {
                        print("green Theme")
                        theme.currentTheme = 0
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Green")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })

                    Button(action: {
                        print("purple Theme")
                        theme.currentTheme = 1
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Purple")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.3673185706, green: 0.001331765903, blue: 0.8576361537, alpha: 1)),Color(#colorLiteral(red: 0.5308707952, green: 0, blue: 0.938947022, alpha: 1)),Color(#colorLiteral(red: 0.6310049295, green: 0, blue: 0.9488027692, alpha: 1)),Color(#colorLiteral(red: 0.6931573749, green: 0, blue: 0.909084022, alpha: 1)),Color(#colorLiteral(red: 0.8202272058, green: 0.02823127806, blue: 0.820595026, alpha: 1)),Color(#colorLiteral(red: 0.8591464162, green: 0.05205651373, blue: 0.7118347287, alpha: 1)),Color(#colorLiteral(red: 0.8968603015, green: 0.06601992249, blue: 0.6419138312, alpha: 1)),Color(#colorLiteral(red: 0.9508308768, green: 0.0824488923, blue: 0.5370048881, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })

                    Button(action: {
                        print("Rustic Theme")
                        theme.currentTheme = 2
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Rustic")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.5884678364, green: 0.4203606844, blue: 0.6142408252, alpha: 1)),Color(#colorLiteral(red: 0.7894214988, green: 0.526325345, blue: 0.525459826, alpha: 1)),Color(#colorLiteral(red: 0.9488562942, green: 0.7211748958, blue: 0.5038855672, alpha: 1)),Color(#colorLiteral(red: 0.9050268531, green: 0.8116474152, blue: 0.7356891036, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })

                    Button(action: {
                        print("Cotton Candy Theme")
                        theme.currentTheme = 3
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Cotton Candy")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.8035505414, green: 0.7060485482, blue: 0.8594198823, alpha: 1)),Color(#colorLiteral(red: 0.9844300151, green: 0.7835456729, blue: 0.8681775928, alpha: 1)),Color(#colorLiteral(red: 0.9792017341, green: 0.6873109341, blue: 0.8015466928, alpha: 1)),Color(#colorLiteral(red: 0.7413480282, green: 0.8779790998, blue: 0.9980034232, alpha: 1)),Color(#colorLiteral(red: 0.6353799701, green: 0.8246542811, blue: 1, alpha: 1))] ), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })

                    Button(action: {
                        print("Pink Theme")
                        theme.currentTheme = 4
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Watermelon")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.9624200463, green: 0.3862091601, blue: 0.5307485461, alpha: 1)),Color(#colorLiteral(red: 0.1496931911, green: 0.5210923553, blue: 0.3988147676, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })

                    Button(action: {
                        print("thoughtful Theme")
                        theme.currentTheme = 5
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Thoughtful")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.1598591506, green: 0.195246309, blue: 0.2541981637, alpha: 1)),Color(#colorLiteral(red: 0.2165521979, green: 0.3225908279, blue: 0.4596990943, alpha: 1)),Color(#colorLiteral(red: 0.5972244143, green: 0.7581434846, blue: 0.8521771431, alpha: 1)),Color(#colorLiteral(red: 0.9321789742, green: 0.4224380553, blue: 0.301848799, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        print("hot pink Theme")
                        theme.currentTheme = 6
                        print(theme.currentTheme)
                        UserDefaults.standard.set(theme.currentTheme, forKey: "currentTheme")
                    }, label: {
                        Text("Hot Pink")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(
                                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.129445374, green: 0.1432131827, blue: 0.1591491401, alpha: 1)),Color(#colorLiteral(red: 0.9582391381, green: 0.3540472686, blue: 0.5360499024, alpha: 1)),Color(#colorLiteral(red: 0.9582391381, green: 0.3540472686, blue: 0.5360499024, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                )
                            .cornerRadius(10)
                    })
                    
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
