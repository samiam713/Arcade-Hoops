import SwiftUI


let storedUsername = "teresa"
let storedpassword = "pass"

struct ContentView: View {
    
    var body: some View {
        //        NavigationView{
        ZStack{
            
            if UIScreen.main.bounds.height > 800{
                Home()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    Home()
                }
            }
        }
        //        }
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
        NavigationView {
            VStack{
                //            Image("userImage")
                //                .resizable()
                //                .frame(width: 340, height: 320)
                UserImage()
                
                VStack(spacing: 4){
                    
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
                    
                }.background(Color.black.opacity(0.1))
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
                    
                    Text("Or")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Color.white.opacity(0.7)
                        .frame(width: 30, height: 1)
                    
                }
                .padding(.top, 5)
                
                //            HStack{
                //
                //                Button(action: {
                //                    playAsGuest = true
                //                }) {
                //                    //                        NavigationLink(destination : GuestHomeScreen()){
                //                    Text("PLAY AS A GUEST")
                //                        .foregroundColor(.white)
                //                        .fontWeight(.bold)
                //                        .padding(.vertical)
                //                        .frame(width: UIScreen.main.bounds.width - 100)
                //                    //                        }
                //
                //                }.background(
                //                    Color.gray
                //                )
                //                .cornerRadius(8)
                //                .offset(y: -40)
                //            }
                //            .padding(.top, 40)
                
                //            NavigationView {
                HStack{
                    NavigationLink(destination: PlayerHomeScreen()) {
                        Text("PLAY AS A GUEST")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                    }
                    .background(Color.gray)
                    .cornerRadius(8)
                    .offset(y: -40)
                }
                .padding(.top, 40)
                //            }
                
                //            TODO: If the user clicks Play As Guest Button, go to game screen for guests
                //            if playAsGuest {
                //
                //            }
                
                
            }
            .padding()
            .padding(.bottom, 80)
        }
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
    
    @State var error = ""
    @State private var alert = false
    //    @Binding var userName: String
    //    @Binding var password: String
    
    var body : some View{
        //        NavigationView {
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    
                    TextField("Username", text: self.$userName)
                        .disableAutocorrection(true)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                }.padding(.vertical, 20)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            //            if authenticationDidFail {
            //                Text("Information not correct. Try again.")
            //                    .offset(y: -10)
            //                    .foregroundColor(.red)
            //            }
            
            //comment starts here
            //            NavigationLink(destination: PlayerHomeScreen(), isActive: $authenticationDidSucceed) {
            //            Button(action: {
            //                // TODO: check if the username and password is stored in the base! IN THE BACKEND
            //                if self.userName == storedUsername && self.password == storedpassword {
            //                    self.authenticationDidSucceed = true;
            //                }
            //                else if self.userName == "" && self.password == ""{
            //                    self.alert = true;
            //                }
            //            }) {
            //
            //                Text("LOGIN")
            //                    .foregroundColor(.white)
            //                    .fontWeight(.bold)
            //                    .padding(.vertical)
            //                    .frame(width: UIScreen.main.bounds.width - 100)
            //
            //            }.background(Color("Color"))
            //            .cornerRadius(8)
            //            .offset(y: -40)
            //            .padding(.bottom, -40)
            //            .alert(isPresented: $alert) {
            //                Alert(title: Text("Invalid Login Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))}
            //            }
            NavigationLink(destination: PlayerHomeScreen(),
                           isActive: self.$authenticationDidSucceed) {
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .onTapGesture {
                        if self.userName == storedUsername && self.password == storedpassword {
                            self.authenticationDidSucceed = true;
                        }
                        //                    else if self.userName == "" && self.password == ""{
                        //                        self.alert = true;
                        //                    }
                        else {
                            self.alert = true;
                        }
                    }
            }
            .background(Color("Color"))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .alert(isPresented: $alert) {
                Alert(title: Text("Invalid Login Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))}
        }
    }
    
    func verify() {
        if self.userName != "" && self.password != ""{
            return
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
}

enum ActiveAlert {
    case first, second
}

struct SignUp : View {
    
    @State var userName: String = ""
    @State var password: String = ""
    
    //    @State var NotUniqueUsername: Bool = false
    
    @State var isSuccessful: Bool = false
    @State var error = ""
    @State var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .first
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    
                    TextField("Username", text: self.$userName)
                        .disableAutocorrection(true)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            //            Button(action: {
            //                if self.userName == "" && self.password == ""{
            //                    self.alert = true;
            //                }
            //            }) {
            //
            //                Text("SIGN UP")
            //                    .foregroundColor(.white)
            //                    .fontWeight(.bold)
            //                    .padding(.vertical)
            //                    .frame(width: UIScreen.main.bounds.width - 100)
            //
            //            }.background(
            //                Color("Color")
            //            )
            //            .cornerRadius(8)
            //            .offset(y: -40)
            //            .padding(.bottom, -40)
            //            .alert(isPresented: $alert) {
            //                Alert(title: Text("Invalid Signup Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))}
            
            NavigationLink(destination: PlayerHomeScreen(),
                           isActive: self.$isSuccessful) {
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .onTapGesture {
                        if self.userName == storedUsername {
                            self.showAlert = true
                            self.activeAlert = .first
                            self.isSuccessful = false;
                        }
                        else if self.userName == "" && self.password == "" {
                            self.showAlert = true
                            self.activeAlert = .second
                            self.isSuccessful = false;
                        }
                        else {
                            self.isSuccessful = true;
                        }
                    }
            }
            .background(Color("Color"))
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            //            .alert(isPresented: $alert) {
            //                Alert(title: Text("Invalid Signup Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))}
            //            .alert(isPresented: $NotUniqueUsername) {
            //                Alert(title: Text("Invalid Signup Information"), message: Text("The username already exists"), dismissButton: .default(Text("Try Again")))}
            //            .alert(isPresented: $showAlert) {
            //                Alert(title: Text("Invalid Signup Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))}
            .alert(isPresented: $showAlert) {
                switch activeAlert{
                case .first:
                    return Alert(title: Text("Invalid Signup Information"), message: Text("The username already exists"), dismissButton: .default(Text("Try Again")))
                case .second:
                    return Alert(title: Text("Invalid Signup Information"), message: Text("Please fill out the username and password correctly"), dismissButton: .default(Text("Try Again")))
                }
            }
        }
    }
}


// Player view where the is going to be two buttons:
// Play game or show leaderboard
struct PlayerHomeScreen : View {
    var body: some View{
        NavigationView {
            VStack{
                
                VStack(spacing: 0){
                    Text("Welcome to ")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.black)
                    HStack{
                        Text("Arcade ")
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundColor(Color("Color"))
                        
                        Text("Hoops!")
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundColor(Color("Color1"))}
                }
                
                Button(action: {
                    
                }) {
                    
                    Text("PLAY GAME")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                .background(Color("Color"))
                .cornerRadius(8)
                .padding(.top, 25)
                
                Button(action: {
                    
                }) {
                    
                    Text("VIEW LEADERBOARD")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                .background(Color("Color"))
                .cornerRadius(8)
                .padding(.top, 10)
                
            }
            .padding(.bottom,40)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

// Guest view where the is going to be two buttons:
// Guest game or show leaderboard
struct GuestHomeScreen : View {
    var body: some View{
        NavigationView {
            VStack{
                
                VStack(spacing: 0){
                    Text("Welcome to ")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.black)
                    HStack{
                        Text("Arcade ")
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundColor(Color("Color"))
                        
                        Text("Hoops!")
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundColor(Color("Color1"))}
                }
                
                Button(action: {
                    
                }) {
                    
                    Text("PLAY GAME")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                .background(Color("Color"))
                .cornerRadius(8)
                .padding(.top, 25)
                
            }
            .padding(.bottom,40)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
