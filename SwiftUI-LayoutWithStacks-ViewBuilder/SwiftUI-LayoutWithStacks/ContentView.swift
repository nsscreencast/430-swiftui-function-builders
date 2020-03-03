import SwiftUI

struct ModalView<Content : View>: View {

    let title: String
    let onClose: () -> Void
    let content: Content

    init(title: String, onClose: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.title = title
        self.onClose = onClose
        self.content = content()
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
            VStack {
                HStack {
                    Text(title)
                    .foregroundColor(.white)
                    .font(.title)
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                }
                Spacer()
                self.content
                Spacer()
            }
            .padding()

        }
    }
}

struct ContentView: View {

    @State var modalVisible = false

    var body: some View {
        ZStack {
            Button(action: {
                self.modalVisible.toggle()
            }) {
                Text("Open Modal")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .clipShape(Capsule())

            ModalView(title: "Modal View", onClose: {
                self.modalVisible.toggle()
            }) {
                Text("Hi there!")
                Text("Some more text")
            }
                .mask(RoundedRectangle(cornerRadius: 35, style: .continuous))
                .offset(x: 0, y: self.modalVisible ? 60 : 1000)
                .shadow(radius: 10)
                .animation(.spring())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
