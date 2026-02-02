//
//  PrintLog.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/2.
//

import CLSDK_Framework

public struct PrintLog {
    public static func printLog() {
        CLSDK.outputModel()
        CLSDK.shared.outputViewRect()
        CLSDK.shared.outputBroadcast()
        CLSDK.shared.outputCombinObserver()
        CLSDK.shared.outputSimpleFac()
        CLSDK.shared.outputMethodFac()
        CLSDK.shared.outputAbstractFac()
        CLSDK.shared.outputGenericFac()
    }
}
