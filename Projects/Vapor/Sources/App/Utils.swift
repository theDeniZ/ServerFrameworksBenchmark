//
//  File.swift
//  
//
//  Created by Dobanda, Denis on 09.07.21.
//

import Foundation

struct JsonResponse: Codable {
    let Number1: String
    let Number2: String
    let Number3: String
    let Number4: String
    let Number5: String
    let Number6: String
    let Number7: String
    let Number8: String
    let Number9: String
    let Number10: String
    let Number11: String
    let Number12: String
    let Number13: String
    let Number14: String
    let Number15: String
    let Number16: String
    let Number17: String
    let Number18: String
    let Number19: String
    let Number20: String
    
    init() {
        Number1 = "Number1"
        Number2 = "Number2"
        Number3 = "Number3"
        Number4 = "Number4"
        Number5 = "Number5"
        Number6 = "Number6"
        Number7 = "Number7"
        Number8 = "Number8"
        Number9 = "Number9"
        Number10 = "Number10"
        Number11 = "Number11"
        Number12 = "Number12"
        Number13 = "Number13"
        Number14 = "Number14"
        Number15 = "Number15"
        Number16 = "Number16"
        Number17 = "Number17"
        Number18 = "Number18"
        Number19 = "Number19"
        Number20 = "Number20"
    }
}

enum Utils {
    static func getSimpleResponse() -> Int {
        Int.random(in: 0..<100)
    }
    
    static func getHarderResponse() -> JsonResponse {
        JsonResponse()
    }
}
