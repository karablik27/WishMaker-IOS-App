import UIKit

// MARK: – Constants
private enum Constants {
    static let viewPadding: CGFloat = 20
    static let sliderVerticalSpacing: CGFloat = 12
    static let buttonTopSpacing: CGFloat = 20
    static let buttonVerticalSpacing: CGFloat = 12
}

final class WishMakerViewController: UIViewController, WishMakerDisplayLogic {
    
    // MARK: – UI Elements
    private let redSlider   = CustomSlider(title: "Red",   min: 0, max: 1)
    private let greenSlider = CustomSlider(title: "Green", min: 0, max: 1)
    private let blueSlider  = CustomSlider(title: "Blue",  min: 0, max: 1)
    private let addButton   = UIButton(type: .system)
    private let calButton   = UIButton(type: .system)

    // MARK: – VIP Properties
    var interactor: WishMakerBusinessLogic?
    var router: WishMakerRoutingLogic?

    // MARK: – Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupVIP()
    }
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    // MARK: – VIP Setup
    private func setupVIP() {
        let interactor = WishMakerInteractor()
        let presenter  = WishMakerPresenter()
        let router     = WishMakerRouter()
        
        self.interactor = interactor
        self.router     = router
        
        interactor.presenter       = presenter
        presenter.viewController   = self
        router.viewController      = self
    }

    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupUI()
        setupActions()
    }

    // MARK: – UI Setup
    private func setupUI() {
        [redSlider, greenSlider, blueSlider, addButton, calButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        addButton.setTitle("Add Wish", for: .normal)
        calButton.setTitle("Schedule", for: .normal)

        NSLayoutConstraint.activate([
            // Red slider
            redSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: Constants.viewPadding),
            redSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.viewPadding),
            redSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Constants.viewPadding),

            // Green slider
            greenSlider.topAnchor.constraint(equalTo: redSlider.bottomAnchor,
                                             constant: Constants.sliderVerticalSpacing),
            greenSlider.leadingAnchor.constraint(equalTo: redSlider.leadingAnchor),
            greenSlider.trailingAnchor.constraint(equalTo: redSlider.trailingAnchor),

            // Blue slider
            blueSlider.topAnchor.constraint(equalTo: greenSlider.bottomAnchor,
                                            constant: Constants.sliderVerticalSpacing),
            blueSlider.leadingAnchor.constraint(equalTo: redSlider.leadingAnchor),
            blueSlider.trailingAnchor.constraint(equalTo: redSlider.trailingAnchor),

            // Add button
            addButton.topAnchor.constraint(equalTo: blueSlider.bottomAnchor,
                                           constant: Constants.buttonTopSpacing),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Schedule button
            calButton.topAnchor.constraint(equalTo: addButton.bottomAnchor,
                                           constant: Constants.buttonVerticalSpacing),
            calButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    // MARK: – Actions Setup
    private func setupActions() {
        let updateColor: () -> Void = { [weak self] in
            guard let self = self else { return }
            let request = WishMaker.Request(
                r: CGFloat(self.redSlider.currentValue),
                g: CGFloat(self.greenSlider.currentValue),
                b: CGFloat(self.blueSlider.currentValue)
            )
            self.interactor?.changeColor(request)
        }

        [redSlider, greenSlider, blueSlider].forEach {
            $0.onValueChanged = { _ in updateColor() }
        }
        addButton.addTarget(self, action: #selector(onAdd), for: .touchUpInside)
        calButton.addTarget(self, action: #selector(onCal), for: .touchUpInside)
    }

    // MARK: – User Actions
    @objc private func onAdd() {
        router?.routeToStore()
    }
    @objc private func onCal() {
        router?.routeToCalendar()
    }

    // MARK: – Display Logic
    func displayColor(_ viewModel: WishMaker.ViewModel) {
        view.backgroundColor = viewModel.bgColor
    }
}
