//
//  UpdateLatestPartsInfo.swift
//  CustomPC
//
//  Created by Kai on 2022/07/17.
//

import Foundation

class UpdateLatestPartsInfo {
    static func fetchPartsSpec(pcParts: [PcParts], index: Int, completionHandler: @escaping ([PcParts]) -> Void) -> Void {
        ParseDetails.getSpec(detailUrl: pcParts[index].detailUrl) { specs in
            if pcParts[index].category == .cpu {
                for spec in specs {
                    if spec.contains("世代第") {
                        pcParts[index].specs.updateValue(spec, forKey: "generation")
                    }
                    
                    if spec.contains("ソケット形状") {
                        pcParts[index].specs.updateValue(spec, forKey: "socket")
                    }
                }
            }
            
            if pcParts[index].category == .cpuCooler {
                for spec in specs {
                    if spec.contains("Intel対応ソケット") {
                        pcParts[index].specs.updateValue(spec, forKey: "intelSocket")
                    }
                    
                    if spec.contains("AMD対応ソケット") {
                        pcParts[index].specs.updateValue(spec, forKey: "amdSocket")
                    }
                }
            }
            
            if pcParts[index].category == .motherBoard {
                for spec in specs {
                    if spec.contains("チップセット") {
                        pcParts[index].specs.updateValue(spec, forKey: "tipset")
                    }
                    
                    if spec.contains("CPUソケット") {
                        pcParts[index].specs.updateValue(spec, forKey: "socket")
                    }
                }
            }
            
            let nextIndex = index + 1
            if nextIndex == pcParts.count {
                completionHandler(pcParts)
                return
            } else {
                self.fetchPartsSpec(pcParts: pcParts, index: nextIndex, completionHandler: completionHandler)
            }
        }
    }
}
