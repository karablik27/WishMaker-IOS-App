import UIKit

// MARK: – Constants
private enum Constants {
    static let textViewInset: CGFloat = 16
    static let textViewHeight: CGFloat = 80
    static let buttonTopOffset: CGFloat = 8
    static let buttonBottomInset: CGFloat = 16
    static let textViewBorderWidth: CGFloat = 1
    static let textViewCornerRadius: CGFloat = 8
}

final class AddWishCell: UITableViewCell {
    
    // MARK: – Public API
    static let reuseId = "AddWishCell"
    var addWish: ((String) -> Void)?
    
    // MARK: – Subviews
    private let tv: UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.layer.borderWidth = Constants.textViewBorderWidth
        t.layer.cornerRadius = Constants.textViewCornerRadius
        return t
    }()
    
    private let btn: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Add Wish", for: .normal)
        return b
    }()
    
    // MARK: – Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(tv)
        contentView.addSubview(btn)
        
        NSLayoutConstraint.activate([
            tv.topAnchor.constraint(equalTo: contentView.topAnchor,
                                     constant: Constants.textViewInset),
            tv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                        constant: Constants.textViewInset),
            tv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                         constant: -Constants.textViewInset),
            tv.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            
            btn.topAnchor.constraint(equalTo: tv.bottomAnchor,
                                     constant: Constants.buttonTopOffset),
            btn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                        constant: -Constants.buttonBottomInset)
        ])
        
        btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: – Actions
    @objc private func tap() {
        addWish?(tv.text)
        tv.text = ""
    }
}
