import UIKit

final class WishMakerInteractor: WishMakerBusinessLogic {
    var presenter: WishMakerPresentationLogic?
    func changeColor(_ request: WishMaker.Request) {
        let uiColor = UIColor(red: request.r, green: request.g, blue: request.b, alpha: 1)
        presenter?.presentColor(WishMaker.Response(color: uiColor))
    }
}
