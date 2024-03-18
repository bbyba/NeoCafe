import UIKit

open class BaseContentViewController<ContentView: BaseContentView>: UIViewController {
    public let contentView: ContentView

    public init(contentView: ContentView = .init()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.setProperties()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func loadView() {
        view = contentView
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
        setupNavigationStyle()
    }

    open func setTargets() {}
    open func setupNavigationStyle() {}
}
