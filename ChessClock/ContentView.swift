//
//  ContentView.swift
//  ChessClock
//
//  Created by Axel Tringa on 2021-03-24.
//

import SwiftUI


struct ContentView: View {
    @State var inputTime : Int = 0
    @State var isSecond : Bool = false
    @State var isActive : Bool = false
    @State var play : Int = 1
    var body: some View{
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(){
                Text("The ChessClock")
                    .font(.title)
                    .foregroundColor(.black)
                LottieView(name: "game", play: $play)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3, alignment: .center)
                Text("Game time ?")
                    .font(.title)
                    .foregroundColor(.black)
                TextField("Time", value: $inputTime, formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                Toggle(isOn: $isSecond) {
                    Label(
                        title: { Text("Second") },
                        icon: { Image(systemName: "timer") })
                        .font(.title)
                }.foregroundColor(.black)
                .padding()
                Button(action: {
                    if(self.inputTime != 0){
                        if (isSecond){
                            isActive.toggle()
                            
                        } else {
                            inputTime *= 60
                            isActive.toggle()
                        }
                    }
                }, label: {
                    Text("Start !")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.leading, 25)
                        .padding(.trailing,25)
                        .background(Color.black, alignment: .center)
                        .cornerRadius(30)
                })
            } .frame(width: UIScreen.main.bounds.width / 2 + 10, height: UIScreen.main.bounds.height , alignment: .center)
            if self.isActive{
                Color.white
                TimerView (time: inputTime, time2: inputTime, originalTime: inputTime)
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
