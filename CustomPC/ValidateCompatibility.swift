//
//  ValidateCompatibility.swift
//  CustomPC
//
//  Created by Kai on 2022/07/29.
//

import Foundation

enum ComatiblityStatus : String {
    case compatible = "選択されたパーツの互換性に問題ありません"
    case incompatible = "選択されたパーツの互換性に問題があります"
    case noSolution = "選択されたパーツは互換性に依存しません"
}

class ValidateCompatibility {
    public static func isCompatible(pcParts: [PcParts]) -> (ComatiblityStatus, String?) {
        var cpu :PcParts? = nil
        var cpuCooler :PcParts? = nil
        var 	
    }
}


