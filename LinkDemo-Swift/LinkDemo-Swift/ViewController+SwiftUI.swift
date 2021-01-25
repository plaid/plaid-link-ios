import UIKit
import SwiftUI

extension ViewController {
    func presentSwiftUILinkToken() {
        let configuration = Self.createLinkTokenConfiguration()
        let contentView = LinkController(configuration: .linkToken(configuration), openOptions: [:]) { (error) in
            print("Handle error: \(error)!") }
        let vc = UIHostingController(rootView: contentView)
        present(vc, animated: true, completion: nil)
    }
}

