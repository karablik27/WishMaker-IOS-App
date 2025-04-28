import UIKit
final class WishStoringViewController: UIViewController, WishStoringDisplayLogic {
    private let table = UITableView()
    var interactor: WishStoringBusinessLogic?
    var router: WishStoringRoutingLogic?
    private var items: [String] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        setupVIP()
    }
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError() }

    private func setupVIP() {
        let i = WishStoringInteractor(), p = WishStoringPresenter(), r = WishStoringRouter()
        interactor = i; router = r
        i.presenter = p; p.viewController = self; r.viewController = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Your Wishes"

        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        table.dataSource = self
        table.delegate   = self
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(close))
        interactor?.fetch()
    }

    @objc private func close() { router?.close() }

    func displayFetch(_ vm: WishStoring.Fetch.ViewModel) {
        items = vm.items; table.reloadData()
    }
    func displayAdd(_ vm: WishStoring.Fetch.ViewModel) {
        items = vm.items; table.reloadData()
    }
}

extension WishStoringViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int { items.count + 1 }
    func tableView(_ tv: UITableView, cellForRowAt i: IndexPath) -> UITableViewCell {
        if i.row == 0 {
            let cell = tv.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: i) as! AddWishCell
            cell.addWish = { [weak self] text in
                self?.interactor?.add(WishStoring.Add.Request(text: text))
            }
            return cell
        } else {
            let cell = tv.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: i) as! WrittenWishCell
            cell.configure(with: items[i.row-1])
            return cell
        }
    }
}
