//
//  ContentView.swift
//  Testsweet
//
//  Created by Jayden Morgan on 8/10/21.
//



import SwiftUI

struct NotificationView: View {

    

    @State private var text1 = "Be Sure your file is saved as a CSV file!"

    @State private var text2 = ""

    @State private var text3 = ""

    @State private var counter = 0

    

    func updateText(){

        if counter == 0{

            text1 = "Be Sure your file is saved as a CSV file!"

            text2 = ""

            text3 = ""

        }

        if counter == 1{

            text1 = "Here is the correct CSV format to submit"

            text2 = "Add a heading:\n SGV, Direction"

            text3 = "Then your readings:\n 100, FLAT\n 120, FLAT "

        }

        if counter == 2{

            text1 = "Here is an Example"

            text2 = "SGV, Direction\n100, FLAT\n110, SINGLE_UP\n40, DOUBLE_DOWN"

            text3 = ""

        }

        if counter == 3{

            text1 = "In Order to add a blank use a -1 in the first cell"

            text2 = "SGV, Direction\n100, FLAT\n-1\n40, DOUBLE_DOWN"

            text3 = ""

        }

        if counter == 4{

            text1 = "How to import your file to your phone"

            text2 = "Step 1:"

            text3 = "Create the file to the proper specifications previously mentioned"

        }

        if counter == 5{

            text1 = "How to import your file to your phone"

            text2 = "Step 2:"

            text3 = "Save file as a CSV in a folder you'll remeber"

        }

        if counter == 6{

            text1 = "How to import your file to your phone"

            text2 = "Step 3:"

            text3 = "Email yourself a copy of that CSV file"

        }

        if counter == 7{

            text1 = "How to import your file to your phone"

            text2 = "Step 4:"

            text3 = "Open that email on your phone and save it to the files app"

        }

        if counter == 8{

            text1 = "How to import your file to your phone"

            text2 = "Finally:"

            text3 = "Click the open button and select that file\n chose a date then click CREATE"

        }

    }

    var body: some View {

        ZStack{

            VStack{

                VStack{

                    Text(text1)

                        .fontWeight(.bold)

                        .bold()

                        .foregroundColor(.white)

                    HStack{

                        Text(text2)

                            .foregroundColor(.white)

                        

                        Text(text3)

                            .foregroundColor(.white)

                    }

                }

                HStack{

                    Button(action: {

                        print("go left")

                        if counter != 0{

                            counter -= 1

                        }

                        updateText()

                    }, label: {

                        if counter == 0{

                            Image(systemName: "arrowshape.turn.up.left")

                        }

                        else{

                            Image(systemName: "arrowshape.turn.up.left.fill")

                        }

                    

                    }).padding()

                    .foregroundColor(.black)

                    

                    Button(action: {

                        print("go right")

                        if counter != 8 {

                            counter += 1

                        }

                        updateText()

                    }, label: {

                        if counter == 8{

                            Image(systemName: "arrowshape.turn.up.right")

                        }

                        else{

                            Image(systemName: "arrowshape.turn.up.right.fill")

                        }

                    

                    }).padding()

                    .foregroundColor(.black)

                      

                }

            }

        }.frame(width: UIScreen.main.bounds.width-20, height: 200)

         .background(Color.gray)

         .cornerRadius(30)

    }

}


 

struct NotificationView_Previews: PreviewProvider {

    static var previews: some View {

        NotificationView()

    }

}
