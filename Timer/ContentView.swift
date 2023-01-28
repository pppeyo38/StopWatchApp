import SwiftUI

struct ContentView: View {
  private let formatter = TimerFormatter()
  
  // ステータス（初期状態、カウント中、停止中）
  @State var status = 0 // 0: initial 1: active 2: stop
  // タイマーの変数
  @State var timerHandler : Timer?
  // 経過時間のカウント
  @State var count = 0.0
  // ラップカウント用
  @State var lapCount = 0.0
  // ラップ時間の配列
  @State var lapArray: [Double] = []
  
  // ボタン関連
  @State var rightBtnText = ["開始", "停止", "開始"]
  @State var rightBtnColor = ["startTextColor", "stopTextColor", "startTextColor"]
  @State var rightBtnBgColor = ["startBtnColor", "stopBtnColor", "startBtnColor"]
  @State var leftBtnText = ["ラップ", "ラップ", "リセット"]
  @State var leftBtnColor = ["inactiveRapTextColor", "rapTextColor", "rapTextColor"]
  @State var leftBtnBgColor = ["inactiveRapBtnColor", "rapBtnColor", "rapBtnColor"]
  
  // --- 関数部分 ---
  func countUpTimer() {
    count += 0.01
    lapCount += 0.01
    if status == 2 {
      timerHandler?.invalidate()
    }
  }
 
  func onStart() {
    status = 1
    timerHandler = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
      _ in countUpTimer()
    }
  }
  
  func onLap(lapTime: Double) {
    lapArray.append(lapTime)
    lapCount = 0.0
  }
  
  func onStop() {
    status = 2
  }
  
  func onReset() {
    count = 0.0
    lapCount = 0.0
    lapArray = []
    status = 0
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
            // ラップ/リセットボタン
            if status == 1 {
              onLap(lapTime: lapCount)
              lapCount = 0.0
            } else if status == 2 {
              onReset()
            }
          }) {
            Text(leftBtnText[status])
              .frame(width: 88, height: 88)
              .foregroundColor(Color(leftBtnColor[status]))
              .background(Color(leftBtnBgColor[status]))
              .clipShape(Circle())
          }
          Spacer()
          Button(action: {
            // 開始/停止ボタン
            if status == 1 {
              onStop()
            } else {
              onStart()
            }
          }) {
            Text(rightBtnText[status])
              .frame(width: 88, height: 88)
              .foregroundColor(Color(rightBtnColor[status]))
              .background(Color(rightBtnBgColor[status]))
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
        
        VStack {
          if status != 0 {
            HStack {
              Text("ラップ\(lapArray.count + 1)")
                .foregroundColor(Color("fontColor"))
              Spacer()
              Text(NSNumber(value: lapCount),  formatter: formatter)
                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .light)))
                .foregroundColor(Color("fontColor"))
            }
            .padding(.horizontal)
          }
          ForEach((0 ..< lapArray.count).reversed(), id: \.self) { index in
            HStack {
              Text("ラップ\(index + 1)")
                .foregroundColor(Color("fontColor"))
              Spacer()
              Text(NSNumber(value: lapArray[index]),  formatter: formatter)
                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .light)))
                .foregroundColor(Color("fontColor"))
            }
            .padding(.horizontal)
          }
        }
        
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
