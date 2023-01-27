import SwiftUI

struct ContentView: View {
  private let formatter = TimerFormatter()
  
  // boolean
  @State var isCount = false
  // タイマーの変数
  @State var timerHandler : Timer?
  // 経過時間のカウント
  @State var count = 0.0
  
  // 開始/停止ボタン関連
  @State var btnText = "開始"
  @State var btnColor = "startTextColor"
  @State var btnBgColor = "startBtnColor"
  
  // --- 関数部分 ---
  func countUpTimer() {
    count += 0.01
    if isCount == false {
      timerHandler?.invalidate()
    }
  }
 
  func onStart() {
    isCount = true
    btnText = "停止"
    btnColor = "stopTextColor"
    btnBgColor = "stopBtnColor"
    
    timerHandler = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
      _ in countUpTimer()
    }
  }
  
  func onStop() {
    isCount = false
    btnText = "開始"
    btnColor = "startTextColor"
    btnBgColor = "startBtnColor"
  }
  
  var body: some View {
    ZStack {
      Color("bgColor")
        .ignoresSafeArea()
      
      VStack {
        VStack {
          Text(NSNumber(value: count),  formatter: formatter)
            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 88, weight: .thin)))
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
            if isCount {
              onStop()
            } else {
              onStart()
            }
          }) {
            Text(btnText)
              .frame(width: 88, height: 88)
              .foregroundColor(Color(btnColor))
              .background(Color(btnBgColor))
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
