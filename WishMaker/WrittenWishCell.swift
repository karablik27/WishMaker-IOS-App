import UIKit

private enum Constants {
    static let WrittenWishCell:String = "WrittenWishCell"
    static let plusConstraint:CGFloat = 16
    static let minusConstraint:CGFloat = -16
    static let numberOfLines:Int = 0
}
final class WrittenWishCell: UITableViewCell {
    static let reuseId = Constants.WrittenWishCell
    private let lbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lbl.numberOfLines = Constants.numberOfLines
        lbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lbl)
        NSLayoutConstraint.activate([
            lbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.plusConstraint),
            lbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.plusConstraint),
            lbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.minusConstraint),
            lbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.minusConstraint)
        ])
    }
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError() }
    func configure(with text: String) { lbl.text = text }
}
