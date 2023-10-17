//
//  Home.swift
//  NewXcode
//
//  Created by Luciano Nicolini on 12/10/2023.
//

import SwiftUI

struct Home: View {
    @State private var intros: [Model] = sampleIntros
    @State private var activateIntro: Model?
    
    func textSize(_ text: String) -> CGFloat {
        return NSString(string: text).size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]).width
    }
    
    func animate(_ index: Int, _ loop: Bool = true) {
        if intros.indices.contains(index + 1 ) {
            activateIntro?.text = intros[index].text
            activateIntro?.textColor = intros[index].textColor
            
            withAnimation(.snappy(duration: 1), completionCriteria: .removed) {
                activateIntro?.textOffset = -(textSize(intros[index].text) + 20)
                activateIntro?.circuleOffset = -(textSize(intros[index].text) + 20) / 2
            } completion: {
                withAnimation(.snappy(duration: 0.8), completionCriteria: .logicallyComplete) {
                    activateIntro?.textOffset = 0
                    activateIntro?.circuleOffset = 0
                    activateIntro?.circuleColor = intros[index + 1].circuleColor
                    activateIntro?.bgColor = intros[index + 1].bgColor
                } completion: {
                    animate(index + 1, loop)
                }
            }
        } else {
            if loop {
                animate(0, loop)
            }
        }
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            VStack {
                if let activateIntro {
                    Rectangle().fill(activateIntro.bgColor)
                        .padding(.bottom, -30)
                        .overlay() {
                            Circle()
                                .fill(activateIntro.circuleColor)
                                .frame(width: 38, height: 38)
                                .background(alignment: .leading, content: {
                                    Capsule().fill(activateIntro.bgColor)
                                        .frame(width: size.width)
                                })
                                .background(alignment: .leading) {
                                    Text(activateIntro.text)
                                        .font(.largeTitle)
                                        .foregroundStyle(activateIntro.textColor)
                                        .frame(width: textSize(activateIntro.text))
                                        .offset(x: 10)
                                        .offset(x: activateIntro.textOffset)
                                }
                                .offset(x: -activateIntro.circuleOffset)
                        }
                    
                }
                LoginButtons()
                    .padding(.bottom, safeArea.bottom)
                    .padding(.top,10)
                    .background(.black,in: .rect(topLeadingRadius: 25, topTrailingRadius: 25))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 8)
            }
            .ignoresSafeArea()
        }
        .task {
            if activateIntro == nil {
                activateIntro = sampleIntros.first
                let oneSecound = UInt64(1_000_000_000 * 0.5)
                try? await Task.sleep(nanoseconds: oneSecound)
                animate(0)
            }
        }
    }
    //Login Button
    @ViewBuilder
    func  LoginButtons() -> some View {
        VStack(spacing: 12) {
            Button {
                
            } label: {
                Label("Preview1", systemImage: "applelogo")
                    .foregroundStyle(.black)
                    .fillButton(.accentColor)
                
            }
            Button {
                
            } label: {
                Label("Preview2", systemImage: "phone.fill")
                    .foregroundStyle(.white)
                    .fillButton(.black)
                
            }
            Button {
                
            } label: {
                Label("Preview3", systemImage: "phone.fill")
                    .foregroundStyle(.white)
                    .fillButton(.indigo)
                
            }
            Button {
                
            } label: {
               Text("Login")
                    .foregroundStyle(.white)
                    .fillButton(.black)
                    .shadow(color: .white, radius: 1)
                
            }
        }
        .padding(15)
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func fillButton(_ color: Color) -> some View {
        self
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical,15)
            .background(color, in: .rect(cornerRadius: 15))
        
    }
}
