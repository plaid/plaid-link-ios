import Foundation
import LinkKit
import LinkKitObjCInternal

extension AssetReportErrorCode {
    var toObjC: PLKAssetReportErrorCode? {
        switch self {
        case .productNotEnabled:
            return .productNotEnabled
        case .dataUnavailable:
            return .dataUnavailable
        case .productNotReady:
            return .productNotReady
        case .assetReportGenerationFailed:
            return .assetReportGenerationFailed
        case .invalidParent:
            return .invalidParent
        case .insightsNotEnabled:
            return .insightsNotEnabled
        case .insightsPreviouslyNotEnabled:
            return .insightsPreviouslyNotEnabled
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}
