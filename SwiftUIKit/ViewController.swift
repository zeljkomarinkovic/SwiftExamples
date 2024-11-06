//
//  ViewController.swift
//  SwiftUIKit
//
//  Created by Zeljko Marinkovic on 06/11/2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let button = Button(action: { self.buttonAction("SwiftUI") }) {
            Text("SwiftUI Button")
        }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .background(Color.blue)
            .foregroundColor(.white)
        let text = Text("SwiftUI Text").background(Color.accentColor)
        let labelSwift = Label("SwiftUI Label", systemImage: "plus").background(Color.green)
        
        var config = UIButton.Configuration.filled()
        config.title = "UIButton"
        let uiButton = UIButton(configuration: config, primaryAction: .init(handler: { _ in
            self.buttonAction("UIKit")
        } ))
        
        let label = UILabel()
        label.text = "UILabel"
        label.backgroundColor = .yellow
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(labelSwift)
        
        stackView.addArrangedSubview(uiButton)
        stackView.addArrangedSubview(label)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView) { view in
            view.backgroundColor = .red
            
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    
    @IBAction func buttonAction(_ sender: String) {
        print("\(sender) button")
    }
}

struct TestView: View {

    
    var body: some View {
        let uiLabel: UILabel = {
            let label = UILabel()
            label.text = "UILabel"
            label.backgroundColor = .brown
            
            return label
        }()
        
        let uiButton: UIButton = {
            var config = UIButton.Configuration.filled()
            config.title = "UIKit Button"
            
            let button = UIButton(configuration: config, primaryAction: .init(handler: { _ in
                print("UIKit button action")
            } ))
            
            return button
        }()
        
        VStack(alignment: .center, spacing: 10) {
            Button(action: { print("SwiftUI View button action") }) {
                Text("SwiftUI Button")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .background(.blue)
            .foregroundColor(.white)
            Text("SwiftUI Text").background(Color.accentColor)
            Label("SwiftUI Label", systemImage: "plus").background(Color.green)
            ViewRepresentable(uiButton)
                .fixedSize()
            ViewRepresentable(uiLabel)
                .fixedSize()
        }
        .background(.yellow)
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    public let viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    func makeUIViewController(context: Context) -> some UIViewController { viewController }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

struct ViewRepresentable<T: UIView>: UIViewRepresentable {
    let view: T
    
    init(_ view: T) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> T { view }
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview("UIViewController", traits: .sizeThatFitsLayout) {
    ViewController()
}

#Preview("SwiftUI view", traits: .sizeThatFitsLayout) {
    TestView()
}

extension UIStackView {
    
    public func addArrangedSubview<Content: View>(_ swiftUIView: Content, completion: ((_ view: UIView) -> Void)? = nil) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        if let view = hostingController.view {
            hostingController.sizingOptions = .intrinsicContentSize
            
            view.backgroundColor = .systemTeal
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addArrangedSubview(view.autoLayout)
            
            completion?(view)
        }
    }
}

extension UIView {
    // MARK: - Auto layout

    var autoLayout: UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    // MARK: - Subviews
    func addSubview(_ view: UIView, completion: (_ view: UIView) -> Void) {
        self.addSubview(view)
        completion(view)
    }
    
    func addSubview<Content: View>(_ view: Content, completion: (_ view: UIView) -> Void) {
        let hostingController = UIHostingController(rootView: view)
        
        if let view = hostingController.view {
            hostingController.sizingOptions = [.intrinsicContentSize]
            
            view.backgroundColor = .clear
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(view.autoLayout)
            
            completion(view)
        }
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else if let nextResponder = self.next as? UIStackView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

protocol Resizable {
    var updateSize: (() -> Void)? { get set }
}

extension UIHostingController {
    func configureResizableViewIfNeeded() {
        guard var resizingView = rootView as? Resizable else { return }
        
        resizingView.updateSize = { [weak self] in
            self?.view?.setNeedsUpdateConstraints()
        }
        
        rootView = resizingView as! Content
    }
}

extension View {
    func readSize(into size: Binding<CGSize>) -> some View {
        self.modifier(SizeReader(size: size))
    }
    
    func readSize(changed: @escaping ((CGSize) -> Void)) -> some View {
        self.modifier(SizeReader(size: .init(get: { .zero }, set: changed)))
    }
}

private struct SizeReader: ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { size = $0 }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value currentValue: inout CGSize, nextValue: () -> CGSize) {
        _ = nextValue()
    }
}
