//
//  TimerView.swift
//  ChessClock
//
//  Created by Axel Tringa on 2021-03-25.
//

import SwiftUI

struct TimerView : View {
    @State private var isActiveWhite : Bool = false
    @State private var isActiveBlack : Bool = false
    @State var time : Int
    @State var time2 : Int
    @State var originalTime : Int
    @State var end : Bool = false
    @State var start : Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(){
            HStack(){
                ZStack{
                    Color.white.ignoresSafeArea()       .onTapGesture(perform: {
                        if isActiveWhite {
                            isActiveBlack.toggle()
                            isActiveWhite.toggle()
                        } else if !start {
                            start.toggle()
                            isActiveWhite.toggle()
                        }
                   })
                    VStack{
                        Label(
                         title: { Text( isActiveWhite == false ? "Pause" : "Play") },
                         icon: { Image(systemName: "play.fill") }
                        ).foregroundColor(.black)
                        .font(.title)
                        .padding()
                        ZStack(){
                            Circle()
                                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 30, lineCap: .round))
            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(1-((originalTime - time) / originalTime)))
                                .stroke(time > originalTime * 60 / 100 ?
                                    Color.green : time > originalTime * 40 / 100 ?  Color.yellow : Color.red , style: StrokeStyle(lineWidth: 30, lineCap: .round))
                                .rotationEffect(.degrees(-90.0))
                                .animation(.easeOut)
                            Text("\(time)")
                                .font(.title)
                                .foregroundColor(.black)
                            
                        }.frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3, alignment: .center)
                        
                    }.frame(width: UIScreen.main.bounds.width / 2 , height: UIScreen.main.bounds.height / 2)
             
                }
                ZStack{
                    Color.black.ignoresSafeArea()       .onTapGesture(perform: {
                        if isActiveBlack{
                            isActiveBlack.toggle()
                            isActiveWhite.toggle()
                        }
                   })
                    VStack{
                        Label(
                         title: { Text( isActiveBlack == false ? "Pause" : "Play") },
                         icon: { Image(systemName: "play.fill") }
                        ).foregroundColor(.white)
                        .font(.title)
                        .padding()
                        ZStack(){
                            Circle()
                                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 30, lineCap: .round))
            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(1-((originalTime - time2) / originalTime)))
                                .stroke(time2 > originalTime * 60 / 100 ?
                                    Color.green : time2 > originalTime * 40 / 100 ?  Color.yellow : Color.red , style: StrokeStyle(lineWidth: 30, lineCap: .round))
                                .rotationEffect(.degrees(-90.0))
                                .animation(.easeOut)
                            Text("\(time2)")
                                .font(.title)
                                .foregroundColor(.white)
                            
                        }.frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3, alignment: .center)
                        
                    }.frame(width: UIScreen.main.bounds.width / 2 , height: UIScreen.main.bounds.height / 2)
             
                }
               
            }
            .onReceive(timer, perform: { _ in
                if isActiveWhite {
                    if (time > 0){
                        time -= 1
                    }
                } else if isActiveBlack{
                    if (time2 > 0) {
                        time2 -= 1
                    }
                }
            })
            Button(action: {
                end.toggle()
            }, label: {
                Text("END")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.red)
                    .cornerRadius(30)
                    
            })
            .offset(x: 0, y: UIScreen.main.bounds.height / 2.8)
        }
        if end{
            ContentView()
        }
      
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(time: 15, time2: 15, originalTime: 15)
    }
}
