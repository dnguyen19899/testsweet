//
//  ContentView.swift
//  Testsweet
//
//  Created by Duy Nguyen and Jayden Morgan on 7/26/21.
//

import SwiftUI

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


struct ContentView: View {
    
    @State private var action: Int? = 0
    @State private var showAlert: Bool = false
    @State private var alertLabel: String = ""
    
    
    private var testsList = [
        Test(title: "Test1", description: "description for test1", expected_result: "expected result for test1", entriesList: [Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT")]),
        Test(title: "Test2", description: "description for test2", expected_result: "expected result for test2", entriesList: [Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT")]),
        Test(title: "Test3", description: "decription for test3", expected_result: "expected result for test3", entriesList: [Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT"), Entry(sgv: "120", direction: "FLAT")])
    ]
    
    let headerHeight = CGFloat(50)
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {

            Color(.white).ignoresSafeArea()

            VStack{

                HeaderView().zIndex(1)
                    .frame(height: headerHeight)
                    .padding(.bottom, 25)

                NavigationView {
                    
                    ZStack {
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            VStack {
                                
                                Spacer().padding(5)
                                
                                ForEach(0..<testsList.count) { index in
                                    
                                    NavigationLink(destination: TestView(title: testsList[index].title, description: testsList[index].description, expected_result: testsList[index].expected_result)) {
                                        
                                        GeometryReader {
                                            
                                            geometry in
                                            VStack {
                                                
                                                Text(testsList[index].title)
                                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                                    .foregroundColor(.white)
                                                
                                            }
                                            .frame(width: 300, height: 100)
                                            .background(Color(hex: 0x1a759f))
                                            .cornerRadius(25)
                                        }
                                        .frame(width:300, height: 100)
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
                                            self.alertLabel = "pencil"
                                            self.showAlert.toggle()

                                            self.action = 2
                                            // Open manual entries adding view here

                                        },
                                        ExpandableButtonItem(label: "square.and.arrow.up") {
                                            self.alertLabel = "square.and.arrow.up"
                                            self.showAlert.toggle()
                                            
                                            // set tag to open CSV Test view
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
                }
            }
        }
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
                        .font(.system(size: 30, weight: .bold))
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
                    .font(.system(size: 30, weight: .bold))
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
