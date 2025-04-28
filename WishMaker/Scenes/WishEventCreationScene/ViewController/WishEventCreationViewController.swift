import UIKit

final class WishEventCreationViewController: UIViewController,
    WishEventCreationDisplayLogic,
    UIPickerViewDataSource,
    UIPickerViewDelegate
{
    // MARK: Public API
    var initialColor: UIColor = .systemBackground
    var onSave: (() -> Void)?

    // VIP
    var interactor: WishEventCreationBusinessLogic?
    var router: WishEventCreationRoutingLogic?

    // UI
    private let wishPicker = UIPickerView()
    private let startPicker = UIDatePicker()
    private let endPicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    private var texts: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        setupUI()
        interactor?.loadWishes(.init())
    }

    private func setupVIP() {
        let i = WishEventCreationInteractor()
        let p = WishEventCreationPresenter()
        let r = WishEventCreationRouter()
        interactor = i; router = r
        i.presenter = p; p.viewController = self; i.router = r
    }

    private func setupUI() {
        view.backgroundColor = initialColor
        title = "New Event"
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .close,
                            target: self,
                            action: #selector(onClose))

        wishPicker.dataSource = self
        wishPicker.delegate   = self
        startPicker.datePickerMode = .dateAndTime
        endPicker.datePickerMode   = .dateAndTime
        saveButton.setTitle("Save Event", for: .normal)
        saveButton.addTarget(self, action: #selector(onSaveTap), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            wishPicker, startPicker, endPicker, saveButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            wishPicker.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    @objc private func onClose() {
        router?.routeBack()
    }

    @objc private func onSaveTap() {
        let req = WishEventCreation.SaveEvent.Request(
            selectedIndex: wishPicker.selectedRow(inComponent: 0),
            start: startPicker.date,
            end: endPicker.date,
            color: view.backgroundColor ?? .systemBackground
        )
        interactor?.saveEvent(req)
    }

    // MARK: DisplayLogic
    func displayWishes(_ vm: WishEventCreation.LoadWishes.ViewModel) {
        texts = vm.texts
        wishPicker.reloadAllComponents()
    }
    func displaySaveSuccess(_ vm: WishEventCreation.SaveEvent.ViewModel) {
        onSave?()
    }

    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        texts.count
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String?
    {
        texts[row]
    }
}
