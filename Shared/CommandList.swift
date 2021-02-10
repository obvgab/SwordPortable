//
//  CommandList.swift
//  SwordPortable
//
//  Created by Obverser on 2/1/21.
//

import Foundation
import SwiftUI

struct CommandItem: Identifiable {
    let id = UUID()
    let title: String
    let function: String //Change Later to datatype
    let trigger: String
}

//Todo, just cleared after merged.
