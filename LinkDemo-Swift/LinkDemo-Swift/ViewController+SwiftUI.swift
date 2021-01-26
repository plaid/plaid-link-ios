import UIKit
import SwiftUI

extension ViewController {
    func presentSwiftUILinkToken() {
        let configuration = Self.createLinkTokenConfiguration()
        presentLinkConfiguration(.linkToken(configuration))
    }
    
    func presentSwiftUIPublicKey() {
        let configuration = Self.createPublicKeyConfiguration()
        presentLinkConfiguration(.publicKey(configuration))
    }
    
    private func presentLinkConfiguration(_ linkConfiguration: LinkController.LinkConfigurationType) {
        let contentView = LinkController(configuration: linkConfiguration, openOptions: [:]) { (error) in
            print("Handle error: \(error)!") }
        let vc = UIHostingController(rootView: contentView)
        present(vc, animated: true, completion: nil)
    }
}

