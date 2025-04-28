import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier = "WishEventCell"
    private let wrap = UIView()
    private let titleLbl = UILabel()
    private let descLbl  = UILabel()
    private let startLbl = UILabel()
    private let endLbl   = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        wrap.translatesAutoresizingMaskIntoConstraints = false
        wrap.layer.cornerRadius = 8
        wrap.backgroundColor    = .secondarySystemBackground
        contentView.addSubview(wrap)

        [titleLbl, descLbl, startLbl, endLbl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            wrap.addSubview($0)
        }
        titleLbl.font = .boldSystemFont(ofSize: 16)
        descLbl.font  = .systemFont(ofSize: 14)
        startLbl.font = .systemFont(ofSize: 12)
        endLbl.font   = .systemFont(ofSize: 12)

        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            wrap.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            wrap.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            wrap.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            titleLbl.topAnchor.constraint(equalTo: wrap.topAnchor, constant: 8),
            titleLbl.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 8),
            titleLbl.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -8),

            descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 4),
            descLbl.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 8),
            descLbl.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -8),

            startLbl.topAnchor.constraint(equalTo: descLbl.bottomAnchor, constant: 6),
            startLbl.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 8),

            endLbl.topAnchor.constraint(equalTo: startLbl.bottomAnchor, constant: 2),
            endLbl.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 8),
            endLbl.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -8),
        ])
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError() }

    func configure(with ev: WishEvent) {
        titleLbl.text = ev.title
        descLbl.text  = ev.details
        if let sd = ev.startDate {
            startLbl.text = "Start: \(DateFormatter.localizedString(from: sd, dateStyle: .short, timeStyle: .short))"
        }
        if let ed = ev.endDate {
            endLbl.text   = "End:   \(DateFormatter.localizedString(from: ed, dateStyle: .short, timeStyle: .short))"
        }
    }
}
