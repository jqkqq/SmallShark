//
//  EditView.swift
//  Imessage
import SwiftUI
import Combine

struct EditView: View {
        
    @ObservedObject var viewModel: EditViewModel
    @State var state: DrawViewState
    @State private var scale: CGFloat = 5
    @State private var color: UIColor = .black
    @State private var showingSheet = false
    
    var body: some View {
        
        VStack {
            Text("編輯修改圖片")
                .font(.system(size: 25))
                .frame(width: UIScreen.main.bounds.width - 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.gray)
            
            DrawRepresentableView(imageName: viewModel.imageName, state: $state, brushWidth: $scale, color: $color, onCommit: { imageView in
                viewModel.mainImageView = imageView.mainImageView
            })
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
             
            HStack {
                Button("上一步") {
                    if state == .back {
                        state = .normal
                    }
                    state = .back
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.yellow)
                
                Button("清除") {
                    if state == .clear {
                        state = .normal
                    }
                    state = .clear
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.green)
                
                Button("分享") {
                    self.showingSheet = true
                }
                .frame(width: UIScreen.main.bounds.width / 3.5, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.orange)
                .sheet(isPresented: $showingSheet,
                               content: {
                    ActivityView(activityItems: [ viewModel.mainImageView?.image as Any ] as [Any], applicationActivities: nil) })
            }

            Slider(value: $scale, in: 1...10, onEditingChanged: { _ in
                state = .normal
            })
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            ScrollView(.horizontal, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                let columns = Array(repeating: GridItem(), count: 1)
                LazyHGrid(rows: columns, content: {
                    ForEach(viewModel.colors, id: \.color) { selectColor in
                        Text(selectColor.select ? "  ✔️ ": "     ")
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
                            .background(Color(selectColor.color))
                            .onTapGesture {
                                viewModel.changeColor.send(selectColor.color)
                                color = selectColor.color
                                state = .normal
                            }
                    }
                })
            })
            
            
            
            Spacer()
        }.background(Color.init(red: 187/255, green: 1, blue: 1))
        
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(viewModel: EditViewModel(imageName: "1"), state: .normal)
    }
}
