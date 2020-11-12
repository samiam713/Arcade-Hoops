//
//  LoginView.swift
//  Arcade Hoops
//
//  Created by Samuel Donovan on 11/10/20.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            if UIScreen.main.bounds.height > 800 {
                Home()
            }
            else{
                ScrollView(.vertical, showsIndicators: false) {
                    Home()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var index = 0
    
    @State var userName: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    @State var playAsGuest: Bool = false
    
    var body : some View{
        
        VStack{
            //            Image("userImage")
            //                .resizable()
            //                .frame(width: 340, height: 320)
            UserImage()
            
            VStack(spacing: 4) {
                
                HStack(spacing: 0){
                    
                    Text("Arcade ")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(Color("Color"))
                    
                    Text("Hoops")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(Color("Color1"))
                }
            }
            //            .padding(.top)
            
            HStack{
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        self.index = 0
                    }
                    
                }) {
                    
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .white : .black)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 0 ? Color("Color") : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        self.index = 1
                    }
                    
                }) {
                    
                    Text("New")
                        .foregroundColor(self.index == 1 ? .white : .black)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 1 ? Color("Color") : Color.clear)
                .clipShape(Capsule())
                
            }.background(Color.gray)
            .clipShape(Capsule())
            .padding(.top, 20)
            
            if self.index == 0{
                Login()
            }
            else{
                SignUp()
            }
            
            HStack(spacing: 15){
                
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                
                Text("or")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color1"))
                
                Color.white.opacity(0.7)
                    .frame(width: 30, height: 1)
                
            }
            .padding(.top, 5)
            
            HStack{
                
                Button(action: {
                    // TODO: PLAY AS GUEST
                }) {
                    
                    Text("PLAY AS A GUEST")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }.background(
                    //                  Color("Color")
                    Color.gray
                )
                .cornerRadius(8)
                .offset(y: -40)
                //                .padding(.bottom, -40)
                //                .shadow(radius: 15)
            }
            .padding(.top, 40)
            
            //            TODO: If the user clicks Play As Guest Button, go to game screen for guests
            //            if playAsGuest {
            //
            //            }
            
            
        }
        //        .padding()
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage")
            .resizable()
            .frame(width: 340, height: 320)
    }
}

struct Login : View {
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    //    @State var mail = ""
    //    @State var pass = ""
    @State var userName: String = ""
    @State var password: String = ""
    //    @Binding var userName: String
    //    @Binding var password: String
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    
                    TextField("Username", text: self.$userName)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                        .foregroundColor(.black)
                    
                }.padding(.vertical, 20)
                ////                .border(Color.gray)
                //                .padding(.horizontal, 20)
                //                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            //              .border(Color.gray)
            .cornerRadius(10)
            .padding(.top, 25)
            //              .overlay(RoundedRectangle(cornerRadius: 10)
            //                          .stroke(Color.gray, lineWidth: 1))
            
            if authenticationDidFail {
                Text("Information not correct. Try again.")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                // TODO: check if the username and password is stored in the base! IN THE BACKEND
                //
                //                if self.username == [USERNAME FROM DATABASE] && self.password == [PASSWORD FROM DATABASE]
                //                    self.authenticationDidSucceed = true
                //                    self.authenticationDidFail = false
                //                } else {
                //                    self.authenticationDidFail = true
                //                    self.authenticationDidSucceed = false
                //                }
                
                if userName == "" || password == ""{
                    // TODO: THROW ERROR TEXT
                    return
                }
                
                
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(
                Color("Color")
            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            //            .shadow(radius: 15)
        }
        //        Text("Incorrect login. Please try again.")
        //            .foregroundColor(.red)
        
        // TODO: if login succeeds, go to screen of the game
        // and send
        //        if authenticationDidSucceed {
        
        //        }
    }
}


struct SignUp : View {
    
    @State var userName: String = ""
    @State var password: String = ""
    
    var body : some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    TextField("Username", text: self.$userName)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    SecureField("Password", text: self.$password)
                        .foregroundColor(.black)
                    
                }
                .padding(.vertical, 20)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Button(action: {
                if userName == "" || password == ""{
                    // TODO: THROW ERROR TEXT
                    return
                }
                // TODO: Send username and password to Backend!
                
            }) {
                Text("SIGN UP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(
                Color("Color")
            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            //            .shadow(radius: 15)
        }
    }
}
