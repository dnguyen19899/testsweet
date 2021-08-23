//
//  File.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/20/21.
//

import Foundation
import SwiftUI



class Themes: ObservableObject {
    
    @Published var currentTheme = UserDefaults.standard.integer(forKey: "currentTheme")
    //Theme Options, must have 5 Colors
    
    
    var regularTheme = [Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.3206463456, green: 0.7150217891, blue: 0.6030768156, alpha: 1)),Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1))]
    var purpleTheme = [Color(#colorLiteral(red: 0.3673185706, green: 0.001331765903, blue: 0.8576361537, alpha: 1)),Color(#colorLiteral(red: 0.5308707952, green: 0, blue: 0.938947022, alpha: 1)),Color(#colorLiteral(red: 0.6310049295, green: 0, blue: 0.9488027692, alpha: 1)),Color(#colorLiteral(red: 0.6931573749, green: 0, blue: 0.909084022, alpha: 1)),Color(#colorLiteral(red: 0.8202272058, green: 0.02823127806, blue: 0.820595026, alpha: 1)),Color(#colorLiteral(red: 0.8591464162, green: 0.05205651373, blue: 0.7118347287, alpha: 1)),Color(#colorLiteral(red: 0.8968603015, green: 0.06601992249, blue: 0.6419138312, alpha: 1)),Color(#colorLiteral(red: 0.9508308768, green: 0.0824488923, blue: 0.5370048881, alpha: 1))]
    var cozyTheme = [Color(#colorLiteral(red: 0.5884678364, green: 0.4203606844, blue: 0.6142408252, alpha: 1)),Color(#colorLiteral(red: 0.7894214988, green: 0.526325345, blue: 0.525459826, alpha: 1)),Color(#colorLiteral(red: 0.9488562942, green: 0.7211748958, blue: 0.5038855672, alpha: 1)),Color(#colorLiteral(red: 0.2171717172, green: 0.2092127124, blue: 0.2028890489, alpha: 1)),Color(#colorLiteral(red: 0.9050268531, green: 0.8116474152, blue: 0.7356891036, alpha: 1))]
    var cottonCandyTheme = [Color(#colorLiteral(red: 0.8035505414, green: 0.7060485482, blue: 0.8594198823, alpha: 1)),Color(#colorLiteral(red: 0.9844300151, green: 0.7835456729, blue: 0.8681775928, alpha: 1)),Color(#colorLiteral(red: 0.9792017341, green: 0.6873109341, blue: 0.8015466928, alpha: 1)),Color(#colorLiteral(red: 0.7413480282, green: 0.8779790998, blue: 0.9980034232, alpha: 1)),Color(#colorLiteral(red: 0.6353799701, green: 0.8246542811, blue: 1, alpha: 1))]
    var pinkTheme = [Color(#colorLiteral(red: 0.9553784728, green: 0.09136072546, blue: 0.3287055492, alpha: 1)),Color(#colorLiteral(red: 0.9666003585, green: 0.2778905332, blue: 0.4963815808, alpha: 1)),Color(#colorLiteral(red: 0.968077004, green: 0.3583317697, blue: 0.543836534, alpha: 1)),Color(#colorLiteral(red: 0.9766011834, green: 0.7450146079, blue: 0.7800876498, alpha: 1)),Color(#colorLiteral(red: 0.9803705812, green: 0.6950640678, blue: 0.7403133512, alpha: 1))]
    var thoughtfulTheme = [Color(#colorLiteral(red: 0.8489733934, green: 0.07412941009, blue: 0.3481240273, alpha: 1)),Color(#colorLiteral(red: 0.5600893497, green: 0.1756859124, blue: 0.3387384415, alpha: 1)),Color(#colorLiteral(red: 0.1402911842, green: 0.5127117038, blue: 0.5016019344, alpha: 1)),Color(#colorLiteral(red: 0.9836252332, green: 0.6937811971, blue: 0.2365075946, alpha: 1)),Color(#colorLiteral(red: 0.4497362375, green: 0.8245891929, blue: 0.8723714948, alpha: 1))]
    
    func printCurrentTheme(){
        print(self.currentTheme)
    }
    func getArray() -> Array<Color>{
        if currentTheme == 0{
            return regularTheme
        }
        if currentTheme == 1{
            return purpleTheme
        }
        if currentTheme == 2{
            return cozyTheme
        }
        if currentTheme == 3{
            return cottonCandyTheme
        }
        if currentTheme == 4{
            return pinkTheme
        }
        if currentTheme == 5{
            return thoughtfulTheme
        }
        return regularTheme
    }
    func getPrimanry() -> Color{
        if currentTheme == 0{
            return regularTheme[6]
        }
        if currentTheme == 1{
            return purpleTheme[1]
        }
        if currentTheme == 2{
            return cozyTheme[0]
        }
        if currentTheme == 3{
            return cottonCandyTheme[1]
        }
        if currentTheme == 4{
            return pinkTheme[1]
        }
        if currentTheme == 5{
            return thoughtfulTheme[4]
        }
        return regularTheme[6]
        
    }
    func getSecondary() -> Color{
        if currentTheme == 0{
            return regularTheme[3]
        }
        if currentTheme == 1{
            return purpleTheme[7]
        }
        if currentTheme == 2{
            return cozyTheme[4]
        }
        if currentTheme == 3{
            return cottonCandyTheme[4]
        }
        if currentTheme == 4{
            return pinkTheme[4]
        }
        if currentTheme == 5{
            return thoughtfulTheme[3]
        }
        return regularTheme[3]
    }
    func getAccent1() -> Color{
        if currentTheme == 0{
            return regularTheme[1]
        }
        if currentTheme == 1{
            return purpleTheme[1]
        }
        if currentTheme == 2{
            return cozyTheme[1]
        }
        if currentTheme == 3{
            return cottonCandyTheme[0]
        }
        if currentTheme == 4{
            return pinkTheme[0]
        }
        if currentTheme == 5{
            return thoughtfulTheme[0]
        }
        return regularTheme[1]
    }
    func getAccent2()-> Color{
        if currentTheme == 0{
            return regularTheme[3]
        }
        if currentTheme == 1{
            return purpleTheme[3]
        }
        if currentTheme == 2{
            return cozyTheme[3]
        }
        if currentTheme == 3{
            return cottonCandyTheme[2]
        }
        if currentTheme == 4{
            return pinkTheme[2]
        }
        if currentTheme == 5{
            return thoughtfulTheme[2]
        }
        return regularTheme[3]
    }
    func getAccent3() -> Color{
        if currentTheme == 0{
            return regularTheme[5]
        }
        if currentTheme == 1{
            return purpleTheme[5]
        }
        if currentTheme == 2{
            return cozyTheme[2]
        }
        if currentTheme == 3{
            return cottonCandyTheme[3]
        }
        if currentTheme == 4{
            return pinkTheme[3]
        }
        if currentTheme == 5{
            return thoughtfulTheme[1]
        }
        return regularTheme[5]
    }
    
}
