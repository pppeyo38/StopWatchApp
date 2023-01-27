import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color("bgColor")
        .ignoresSafeArea()
      
      VStack {
        VStack {
          Text("00:00.00")
            .font(.system(size: 88, weight: .thin, design: .default))
            .foregroundColor(Color("fontColor"))
            .padding(.vertical, 80.0)
        }
        .padding(.top, 50.0)
  
        HStack {
          Button(action: {
            // ラップボタン
          }) {
            Text("ラップ")
              .frame(width: 88, height: 88)
              .foregroundColor(Color("rapTextColor"))
              .background(Color("rapBtnColor"))
              .clipShape(Circle())
          }
          Spacer()
          Button(action: {
            // 開始/停止ボタン
          }) {
            Text("開始")
              .frame(width: 88, height: 88)
              .foregroundColor(Color("startTextColor"))
              .background(Color("startBtnColor"))
              .clipShape(Circle())
          }
        }
        .padding(.horizontal)
        VStack {
          Divider()
            .frame(height: 1.0)
            .background(Color("strokeColor"))
        }
        .padding([.top, .leading, .trailing])
        Spacer()
        
      }
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
