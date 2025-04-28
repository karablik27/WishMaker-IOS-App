import UIKit

@available(iOS 14.0, *)
final class WishCalendarViewController: UIViewController,
    WishCalendarDisplayLogic,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private var events: [WishEvent] = []
    var interactor: WishCalendarBusinessLogic?
    var router: WishCalendarRoutingLogic?

    private lazy var collectionView: UICollectionView = {
        var cfg = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        cfg.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard let self = self else { return nil }
            let action = UIContextualAction(style: .destructive, title: "Delete") { _,_,done in
                self.interactor?.deleteEvent(.init(index: indexPath.item))
                done(true)
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
        let layout = UICollectionViewCompositionalLayout.list(using: cfg)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        title = "Schedule Wishes"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(onAdd))
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        interactor?.fetchEvents(.init())
    }

    private func setupVIP() {
        let i = WishCalendarInteractor()
        let p = WishCalendarPresenter()
        let r = WishCalendarRouter()
        interactor = i; router = r
        i.presenter = p; p.viewController = self; r.viewController = self
    }

    @objc private func onAdd() {
        router?.routeToCreateEvent(initialColor: view.backgroundColor ?? .systemBackground)
    }

    // MARK: DisplayLogic

    func displayFetchEvents(_ vm: WishCalendar.FetchEvents.ViewModel) {
        events = vm.events
        collectionView.reloadData()
    }
    func displayDeleteEvent(_ vm: WishCalendar.DeleteEvent.ViewModel) {
        events = vm.events
        collectionView.reloadData()
    }

    // MARK: UICollectionView

    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }
    func collectionView(_ cv: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier,
                                           for: indexPath) as! WishEventCell
        cell.configure(with: events[indexPath.item])
        return cell
    }
    func collectionView(_ cv: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize
    {
        CGSize(width: cv.bounds.width, height: 120)
    }
}
