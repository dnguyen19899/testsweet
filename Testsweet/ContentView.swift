//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen and Jayden Morgan on 7/26/21.
//

import SwiftUI

//Global Variables
// var testsList = UserDefaults.standard.testsList



extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

extension UserDefaults {
    
    var testsList: [Test] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "testsList") else { return [] }
            return (try? PropertyListDecoder().decode([Test].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "testsList")
        }
    }
}

struct ContentView: View {
    
    @State private var action: Int? = 0
    @State private var playgroundMode = false

    let headerHeight = CGFloat(50)
    @State private var indices: [Test] = []
    //@State private var count: Int = UserDefaults.standard.testsList.count
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            Color(.white).ignoresSafeArea()
            
            VStack{
                
                HeaderView(playgroundMode: $playgroundMode).zIndex(1)
                    .frame(height: headerHeight)
                    .padding(.bottom, 25)
                
                
                NavigationView {
                    
                    ZStack {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            VStack {
                                
                                Spacer().padding(5)
                                
                                ForEach(UserDefaults.standard.testsList, id: \.self) { test in
                                    
                                    if !indices.contains(test) {
                                        
                                        RowContent(test: test, indices: $indices)
                                    
//                                        HStack {
//
//                                            NavigationLink(destination: TestView(test: UserDefaults.standard.testsList[index])) {
//
//
//                                                GeometryReader {
//
//                                                    geometry in
//
//                                                    VStack {
//
//                                                        Text(UserDefaults.standard.testsList[index].title)
//                                                            .font(.system(size: 20, weight: .heavy, design: .default))
//                                                            .foregroundColor(Color.white)
//                                                            .padding(.trailing)
//
//                                                    }
//                                                    .frame(width: 260, height: 75)
//                                                    .background( LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09433246404, green: 0.3047628701, blue: 0.4649187326, alpha: 1)),Color(#colorLiteral(red: 0.1185745522, green: 0.3756733537, blue: 0.5679591298, alpha: 1)),Color(#colorLiteral(red: 0.1062038764, green: 0.4604464173, blue: 0.6242554784, alpha: 1)),Color(#colorLiteral(red: 0.1607481241, green: 0.5125916004, blue: 0.5261992216, alpha: 1)),Color(#colorLiteral(red: 0.162745297, green: 0.5202785134, blue: 0.5380410552, alpha: 1)),Color(#colorLiteral(red: 0.2764765024, green: 0.6270785928, blue: 0.5273578763, alpha: 1)),Color(#colorLiteral(red: 0.4004970789, green: 0.6831317544, blue: 0.5014337301, alpha: 1)),Color(#colorLiteral(red: 0.5550227761, green: 0.791927278, blue: 0.5073714256, alpha: 1)),Color(#colorLiteral(red: 0.6706730127, green: 0.845440805, blue: 0.5175511241, alpha: 1)),Color(#colorLiteral(red: 0.7970537543, green: 0.8742372394, blue: 0.5379388928, alpha: 1)),]), startPoint: .leading, endPoint: .trailing))
//                                                    .cornerRadius(25)
//                                                }
//                                                .frame(width:260, height: 100)
//
//                                            }
//
//                                            GeometryReader {
//
//                                                geometry in
//
//                                                VStack {
//
//                                                    Button(action: {
//                                                        print("delete \(UserDefaults.standard.testsList[index].title)")
//
//                                                        deleted.append(UserDefaults.standard.testsList[index].id)
//
//                                                        UserDefaults.standard.testsList.remove(at: index)
//
//                                                    }) {
//                                                        Image(systemName: "trash")
//                                                            .font(.system(size: 25, weight: .bold))
//                                                            .foregroundColor(Color.white)
//                                                    }
//                                                }
//                                                .frame(width: 60, height: 60)
//                                                .background(Color.red)
//                                                .cornerRadius(50)
//                                            }
//                                            .frame(width: 60, height: 90)
//                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        
                        // Navigation Links to the Test Creation Views
                        // which are triggered by tags set in the add buttons
                        NavigationLink(destination: CSVTestView(), tag: 1, selection: $action)
                        {
                            EmptyView()
                            
                        }
                        
                        NavigationLink(destination: ManualTestView(), tag: 2, selection: $action)
                        {
                            EmptyView()
                            
                        }
                        
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                ExpandableButtonPanel(
                                    primaryItem: ExpandableButtonItem(label: "plus"),
                                    secondaryItems: [
                                        ExpandableButtonItem(label: "pencil") {
                                            
                                            self.action = 2
                                            
                                        },
                                        ExpandableButtonItem(label: "square.and.arrow.up") {
                                            
                                            self.action = 1
                                        }
                                    ]
                                )
                                .padding()
                            }
                        }
                    }
                    .navigationBarTitle("HOME", displayMode: .inline)
                    .navigationBarColor(UIColor(hex: 0x52b69a))
                    .background(backgroundView())
                }
            }
            
            GraphedView()
            if playgroundMode {
                PlaygroundView(playgroundMode: $playgroundMode)
            }
        }.onAppear(perform: {
            if UserDefaults.standard.testsList.isEmpty {
                UserDefaults.standard.testsList = [Test]()
            }
            
            print(UserDefaults.standard.testsList.count)
        })
        
        
    }
    
}


// helper struct for navigation styling
struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

// helper structs for expandable button
struct ExpandableButtonItem: Identifiable {
    let id = UUID()
    let label: String
    private(set) var action: (() -> Void)? = nil
}

struct ExpandableButtonPanel: View {
    
    let primaryItem: ExpandableButtonItem
    let secondaryItems: [ExpandableButtonItem]
    
    private let noop: () -> Void = {}
    private let size: CGFloat = 70
    private var cornerRadius: CGFloat {
        get { size / 2 }
    }
    private let shadowColor = Color.black.opacity(0.4)
    private let shadowPosition: (x: CGFloat, y: CGFloat) = (x: 2, y: 2)
    private let shadowRadius: CGFloat = 3
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            ForEach(secondaryItems) { item in
                Button(action: item.action ?? self.noop)
                {
                    Image(systemName: item.label)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color(hex: 0x212529))
                }
                .frame(
                    width: self.isExpanded ? self.size : 0,
                    height: self.isExpanded ? self.size : 0)
            }
            
            Button(action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
                self.primaryItem.action?()
            })
            {
                Image(systemName: primaryItem.label)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color(hex: 0x212529))
            }
            .frame(width: size, height: size)
        }
        .background(Color(hex: 0x52b69a))
        .cornerRadius(cornerRadius)
        .font(.title)
        .shadow(
            color: shadowColor,
            radius: shadowRadius,
            x: shadowPosition.x,
            y: shadowPosition.y
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
