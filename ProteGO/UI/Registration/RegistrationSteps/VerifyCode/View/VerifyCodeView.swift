import UIKit
import SnapKit
import RxCocoa

final class VerifyCodeView: UIView {

    var verifyCodeButtonTapEvent: ControlEvent<Void> {
        return verifyCodeButton.rx.tap
    }

    var code: String {
        return codeTextField.text ?? ""
    }

    private let titleLabel = UILabel.with(text: L10n.registrationVerifyTitle, fontStyle: .headline)

    private let descriptionLabel = UILabel.with(text: L10n.registrationVerifyDescription, fontStyle: .body)

    private let codeTextField: UITextField = {
        let textField = UITextField.with(placeholder: L10n.registrationVerifyCodePlaceholder)
        textField.autocorrectionType = .no
        textField.textContentType = .oneTimeCode
        textField.returnKeyType = .send
        return textField
    }()

    private let verifyCodeButton = UIButton.rectButton(text: L10n.registrationVerifyBtn)

    init(codeTextFieldDelegate: UITextFieldDelegate) {
        super.init(frame: .zero)
        backgroundColor = .white

        codeTextField.delegate = codeTextFieldDelegate

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(phoneNumber: String) {
        descriptionLabel.text = "Wpisz swój kod, który otrzymałeś w SMSie wysłanym na numer \(phoneNumber)"
    }

    func dismissKeyboard() {
        codeTextField.resignFirstResponder()
    }

    private func addSubviews() {
        addSubviews([titleLabel, descriptionLabel, codeTextField, verifyCodeButton])
    }

    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0.028 * UIScreen.height)
            $0.leading.equalToSuperview().offset(0.064 * UIScreen.width)
            $0.trailing.equalToSuperview().offset(-0.064 * UIScreen.width)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(0.021 * UIScreen.height)
            $0.leading.trailing.equalTo(titleLabel)
        }

        codeTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(0.038 * UIScreen.height)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(48)
        }

        verifyCodeButton.snp.makeConstraints {
            $0.top.equalTo(codeTextField.snp.bottom).offset(0.030 * UIScreen.height)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(48)
        }
    }
}