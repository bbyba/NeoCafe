import UIKit

public typealias BaseViewController = BaseContentViewModelController

open class BaseContentViewModelController<ViewModel: NSObject,
    ContentView: BaseContentView>: BaseContentViewController<ContentView>
{
    public let viewModel: ViewModel

    public init(viewModel: ViewModel, contentView: ContentView = .init()) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
        self.contentView.setProperties()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
