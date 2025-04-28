import UIKit

// MARK: – Constants
private enum Constants {
    static let viewPadding: CGFloat = 8
    static let labelSliderSpacing: CGFloat = 4
    static let sliderHorizontalInset: CGFloat = 8
}

final class CustomSlider: UIView {
    
    // MARK: – Public API
    var onValueChanged: ((Float) -> Void)?
    var currentValue: Float { slider.value }
    
    // MARK: – Subviews
    private let label = UILabel()
    private let slider = UISlider()

    // MARK: – Init
    init(title: String, min: Float, max: Float) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        // Configure subviews
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        
        slider.minimumValue = min
        slider.maximumValue = max
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(changed), for: .valueChanged)
        
        // Add and constrain
        addSubview(label)
        addSubview(slider)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.viewPadding),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.viewPadding),
            
            slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.labelSliderSpacing),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderHorizontalInset),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sliderHorizontalInset),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.viewPadding)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: – Actions
    @objc private func changed() {
        onValueChanged?(slider.value)
    }
}
