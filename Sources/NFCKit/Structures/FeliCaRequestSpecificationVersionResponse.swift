//
//  FeliCaRequestSpecificationVersionResponse.swift
//  
//
//  Created by treastrain on 2021/02/19.
//

import Foundation
#if os(iOS)
import CoreNFC
#endif

/// Response from Request Specification Version command.
public struct FeliCaRequestSpecificationVersionResponse {
    public init(statusFlag1: Int, statusFlag2: Int, basicVersion: Data?, optionVersion: Data?) {
        self.statusFlag1 = statusFlag1
        self.statusFlag2 = statusFlag2
        self.basicVersion = basicVersion
        self.optionVersion = optionVersion
    }
    
    #if os(iOS) && !targetEnvironment(macCatalyst)
    @available(iOS 14.0, *)
    public init(from coreNFCInstance: CoreNFC.NFCFeliCaRequestSpecificationVersionResponse) {
        self.statusFlag1 = coreNFCInstance.statusFlag1
        self.statusFlag2 = coreNFCInstance.statusFlag2
        self.basicVersion = coreNFCInstance.basicVersion
        self.optionVersion = coreNFCInstance.optionVersion
    }
    #endif
    
    /// Status flag 1.
    public var statusFlag1: Int

    /// Status flag 2.
    public var statusFlag2: Int

    /// Basic version.
    public var basicVersion: Data?

    /// Option version.
    public var optionVersion: Data?
}
