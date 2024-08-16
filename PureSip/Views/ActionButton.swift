import SwiftUI

public struct ActionButton<Label: View>: View {
    
    var buttonSize: CGFloat
    var actions: [FloatingAction]
    var label: (Bool) -> Label
    init(@FloatingButtonActionBuilder actions: @escaping () -> [FloatingAction],
         @ViewBuilder label: @escaping (Bool) -> Label, buttonSize: CGFloat = 50) {
        self.buttonSize = buttonSize
        self.actions = actions()
        self.label = label
    }
    
    @State private var isExpanded: Bool = false
    public var body: some View {
        Button {
            isExpanded.toggle()
        } label: {
            label(isExpanded)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .buttonStyle(NoAnimationButtonStyle())
        .background {
            ZStack {
                ForEach(actions) { action in
                    createAction(action)
                }
            }
            .frame(width: buttonSize, height: buttonSize)
        }
        .animation(.snappy(duration: 0.4, extraBounce: 0), value: isExpanded)
    }
}

// MARK: Functions and Computed Properties

private extension ActionButton {
    @ViewBuilder
    func createAction(_ action: FloatingAction) -> some View {
        let index = CGFloat(actions.firstIndex(where: { $0.id == action.id }) ?? 0)
        
        Button {
            action.action()
            isExpanded = false
        } label: {
            Image(systemName: action.symbol)
                .font(action.font)
                .foregroundColor(action.tint)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.circle)
                .background(action.background, in: .circle)
        }
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpanded)
        .opacity(!isExpanded ? 0 : 1)
        .offset(y: isExpanded ? verticalOffset(for: index) : 0)
        .offset(x: isExpanded ? horizontalOffset(for: index) : 0)
    }
    
    func verticalOffset(for index: CGFloat) -> CGFloat {
        return buttonSize + 10
    }
    
    func horizontalOffset(for index: CGFloat) -> CGFloat {
        if index == 0 {
            return 0
        } else if Int(index) % 2 == 0 {
            return buttonSize + 10
        } else {
            return -(buttonSize + 10)
        }
    }
}

// MARK: Custom Button Styles

fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

fileprivate struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: configuration.isPressed)
    }
}

// MARK: Floating Actions

struct FloatingAction: Identifiable {
    private(set) var id: UUID = .init()
    var symbol: String
    var tint: Color = .white
    var font: Font = .title3
    var background: Color = .black
    var action: () -> ()
}

@resultBuilder
struct FloatingButtonActionBuilder {
    static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap({ $0 })
    }
}

// MARK: Previews

#Preview {
    ActionButton(actions: {
        FloatingAction(symbol: "pencil", tint: .white, font: .headline, background: .black) {
            print("pencil")
        }
        FloatingAction(symbol: "eraser.line.dashed.fill", tint: .white, font: .body, background: .black) {
            print("eraser")
        }
        FloatingAction(symbol: "folder.fill", tint: .white, font: .body, background: .black) {
            print("folder")
        }
    }, label: { isExpanded in
        Image(systemName: "plus")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
            .scaleEffect(1.02)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black, in: .circle)
            .scaleEffect(isExpanded ? 0.9 : 1)
    }, buttonSize: 50)
}
