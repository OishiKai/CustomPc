//
//  ValidateCompatibility.swift
//  CustomPC
//
//  Created by Kai on 2022/07/29.
//

import Foundation

class ValidateCompatibility {
    // 互換性判定メソッド
    // 互換性に問題がある場合 -> 互換性エラーメッセージ
    // 互換性に問題ない場合   -> nil
    public static func isCompatible(pcParts: [PcParts]) -> String? {
        var incompatibleMessage = ""
        var cpu :PcParts?
        var cpuCooler :PcParts?
        var memory :PcParts?
        var motherBoard :PcParts?
        
        for parts in pcParts {
            switch (parts.category) {
            case .cpu:
                cpu = parts
            case .cpuCooler:
                cpuCooler = parts
            case .memory:
                memory = parts
            case .motherBoard:
                motherBoard = parts
            default : break
            }
        }
        
        // マザーボードが選ばれていない場合
        guard let motherBoard = motherBoard else {
            return nil
        }
        
        // cpu mother チェック
        if let cpu = cpu {
            if (!validateSocket(cpu: cpu, motherBoard:motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage += "CPUとマザーボードのソケット形状\n"
            }
            
//            if (!validateTipset(cpu: cpu, motherBoard: motherBoard)) {
//                // チップセットが対応していない場合
//                incompatibleMessage += "CPUとマザーボードのチップセット"
//            }
        }
        
        // cpuCooler mother
        if let cpuCooler = cpuCooler {
            if (!validateSocket(cpuCooler: cpuCooler, motherBoard: motherBoard)) {
                // ソケット形状が異なる場合
                incompatibleMessage += "CPUクーラーとマザーボードのソケット形状\n"
            }
        }
        
        // memory mother
        if let memory = memory {
            if (!validateSocket(memory: memory, motherBoard: motherBoard)) {
                // 規格が異なる場合
                incompatibleMessage += "メモリーとマザーボードの規格\n"
            }
            
            if (!MemoryLessThanSlotsCapacity(memory: memory, motherBoard: motherBoard)) {
                // メモリの枚数がスロット数を超えている場合
                incompatibleMessage += "メモリーの枚数とマザーボードのスロットの数\n"
            }
        }
        
        if incompatibleMessage == "" {
            return nil
        } else {
            incompatibleMessage.removeLast(1)
            return incompatibleMessage
        }
    }
    
    private static func validateSocket(cpu:PcParts, motherBoard:PcParts) -> Bool {
        // CPUソケット情報格納例) "ソケット形状 LGA1700" -> "LGA1700"
        guard var cpuSocket = cpu.specs["socket"] else { return false }
        cpuSocket = cpuSocket.replacingOccurrences(of: "ソケット形状 ", with: "")
        
        // マザーボードソケット情報格納例) "CPUソケットLGA1700" -> "LGA1700"
        guard var motherBoardSocket = motherBoard.specs["socket"] else { return false }
        motherBoardSocket = motherBoardSocket.replacingOccurrences(of: "CPUソケット", with: "")
        
        if cpuSocket == motherBoardSocket { return true }
        
        return false
    }
    
//    private static func validateTipset(cpu:PcParts, motherBoard:PcParts) -> Bool {
//
//        return false
//    }
    
    private static func validateSocket(cpuCooler:PcParts, motherBoard:PcParts) -> Bool {
        var compatible = false
        // マザーボードの対応CPUが INTEL or AMD のどちらかをチップセットから判断
        guard let tipset = motherBoard.specs["tipset"] else { return false }
        if tipset.contains("INTEL") {
            
            // CPUクーラーINTELソケット情報格納例) "Intel対応ソケットLGA 2066/2011-3LGA 1700/1200" -> ["2066", "2011-3","1700", "1200"]
            guard var cpuCoolerSocket = cpuCooler.specs["intelSocket"] else { return false }
            cpuCoolerSocket = cpuCoolerSocket.replacingOccurrences(of: "Intel対応ソケットLGA ", with: "").replacingOccurrences(of: "LGA ", with: "/")
            let cpuCoolerSocketList = cpuCoolerSocket.split(separator: "/")
            
            // マザーボードソケット情報格納例) "CPUソケットLGA1700" -> "LGA1700"
            guard var motherBoardSocket = motherBoard.specs["socket"] else { return false }
            motherBoardSocket = motherBoardSocket.replacingOccurrences(of: "CPUソケット", with: "")
            
            // ソケットを比較
            for so in cpuCoolerSocketList {
                if motherBoardSocket == "LGA" + so {
                    compatible = true
                }
            }
            
        } else if tipset.contains("AMD") {
            // CPUクーラーAMDソケット情報格納例)
            guard var cpuCoolerSocket = cpuCooler.specs["amdSocket"] else { return false }
            cpuCoolerSocket = cpuCoolerSocket.replacingOccurrences(of: "AMD対応ソケット", with: "")
            let cpuCoolerSocketList = cpuCoolerSocket.split(separator: "/")
            
            // CPUクーラーページのAMDソケット情報の改行文字が省略され、2種のソケットがつながってしまう場合の対応
            // "TR4"<br>"AM4/AM3" -> ["TR4AM4", "AM3"]  --  TR4 と AM4 がつながってしまっている
            var splitedSocketList:[String] = []
            for ccs in cpuCoolerSocketList {
                // ソケット情報をひとつづつ検証
                var baseStr = ""
                var splitStr = ""
                for (index, char) in ccs.enumerated() {
                    // ソケット情報の文字列を1文字づつ検証
                    baseStr += String(char)
                    
                    if Int(String(char)) != nil && index != (ccs.utf8.count - 1){
                        // ソケット情報の最後尾以外に数字が含まれている場合
                        splitStr = baseStr
                        baseStr = ""
                    }
                }
                
                if splitStr != "" {
                    splitedSocketList.append(splitStr)
                }
                splitedSocketList.append(baseStr)
            }
            
            guard var motherBoardSocket = motherBoard.specs["socket"] else { return false }
            motherBoardSocket = motherBoardSocket.replacingOccurrences(of: "CPUソケットSocket", with: "")
            
            for socket in splitedSocketList {
                if socket == motherBoardSocket {
                    compatible = true
                }
            }
        }
        
        return compatible
    }
    
    private static func validateSocket(memory:PcParts, motherBoard:PcParts) -> Bool {
        // メモリインターフェイス 格納例) "メモリインターフェイスDIMM" -> "DIMM"
        guard let memoryInterFace = memory.specs["memoryInterface"]?.replacingOccurrences(of: "メモリインターフェイス", with: "") else { return false }
        // メモリ規格 格納例) "メモリ規格DDR4 SDRAM" -> "DDR4 SDRAM" -> "DDR4"
        guard let memoryStandard = memory.specs["memoryStandard"]?.replacingOccurrences(of: "メモリ規格", with: "").split(separator: " ")[0] else { return false }
        // マザーボードメモリソケット 格納例) "詳細メモリタイプDIMM DDR4" -> "DIMM DDR5"
        guard let memoryType = motherBoard.specs["memoryType"]?.replacingOccurrences(of: "詳細メモリタイプ", with: "") else { return false }
        
        if memoryType.contains(memoryInterFace) && memoryType.contains(memoryStandard) {
            return true
        }
        return false
    }
    
    private static func MemoryLessThanSlotsCapacity(memory:PcParts, motherBoard:PcParts) -> Bool {
        // メモリ枚数 格納例) "枚数1枚" -> 1
        guard let numberOfSheets = memory.specs["numbarOfSheets"]?.replacingOccurrences(of: "数", with: "").replacingOccurrences(of: "枚", with: "") else { return false }
        // マザーボードのメモリスロット数
        guard let numberOfSlots = motherBoard.specs["numberOfSlots"]?.replacingOccurrences(of: "メモリスロット数", with: "") else { return false }
        
        if let sheets = Int(numberOfSheets) {
            if let slots = Int(numberOfSlots) {
                if sheets <= slots { return true }
            }
        }
        return false
    }
}



