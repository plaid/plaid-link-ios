import Foundation
import LinkKit
import LinkKitObjCInternal

extension EventMetadata {
    var toObjC: PLKEventMetadata {
        let error: ExitError? = errorCode.map {
            ExitError.privateObjCInitializer(
                errorCode: $0,
                errorMessage: errorMessage ?? "",
                displayMesssage: nil,
                errorJSON: nil
            )
        }

        return PLKEventMetadata(
            error: error?.toObjC,
            exitStatus: exitStatus?.toObjC,
            institutionID: institutionID,
            institutionName: institutionName,
            institutionSearchQuery: institutionSearchQuery,
            accountNumberMask: accountNumberMask,
            isUpdateMode: isUpdateMode,
            matchReason: matchReason,
            issueID: issueID,
            issueDescription: issueDescription,
            issueDetectedAt: issueDetectedAt,
            routingNumber: routingNumber,
            selection: selection,
            linkSessionID: linkSessionID,
            mfaType: mfaType?.toObjC ?? .none,
            requestID: requestID,
            timestamp: timestamp,
            viewName: viewName?.toObjC,
            metadataJSON: metadataJSON
        )
    }
}
