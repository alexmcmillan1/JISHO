//
//  Kana.swift
//  JISHO
//
//  Created by Alex on 26/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

enum Kana: String {
    case a = "あ"
    case i = "い"
    case u = "う"
    case e = "え"
    case o = "お"
    case ka = "か"
    case ki = "き"
    case ku = "く"
    case ke = "け"
    case ko = "こ"
    case ga = "が"
    case gi = "ぎ"
    case gu = "ぐ"
    case ge = "げ"
    case go = "ご"
    case sa = "さ"
    case shi = "し"
    case su = "す"
    case se = "せ"
    case so = "そ"
    case za = "ざ"
    case ji = "じ"
    case zu = "ず"
    case ze = "ぜ"
    case zo = "ぞ"
    case ta = "た"
    case chi = "ち"
    case tsu = "つ"
    case te = "て"
    case to = "と"
    case da = "だ"
    case di = "ぢ"
    case du = "づ"
    case de = "で"
    case `do` = "ど"
    case na = "な"
    case ni = "に"
    case nu = "ぬ"
    case ne = "ね"
    case no = "の"
    case ha = "は"
    case hi = "ひ"
    case fu = "ふ"
    case he = "へ"
    case ho = "ほ"
    case ba = "ば"
    case bi = "び"
    case bu = "ぶ"
    case be = "べ"
    case bo = "ぼ"
    case pa = "ぱ"
    case pi = "ぴ"
    case pu = "ぷ"
    case pe = "ぺ"
    case po = "ぽ"
    case ma = "ま"
    case mi = "み"
    case mu = "む"
    case me = "め"
    case mo = "も"
    case ya = "や"
    case yu = "ゆ"
    case yo = "よ"
    case ra = "ら"
    case ri = "り"
    case ru = "る"
    case re = "れ"
    case ro = "ろ"
    case wa = "わ"
    case wo = "を"
    case n = "ん"
    case doubleNextConsonant = "っ"
    case smallYa = "ゃ"
    case smallYu = "ゅ"
    case smallYo = "ょ"
    
    var isSmallModifier: Bool {
        return [Kana.smallYa, Kana.smallYu, Kana.smallYo].contains(self)
    }
    
    var smallModifierRomaji: String {
        switch self {
        case .smallYa: return Kana.ya.romaji
        case .smallYu: return Kana.yu.romaji
        case .smallYo: return Kana.yo.romaji
        default: return romaji
        }
    }
    
    var romaji: String {
        switch self {
        case .a:
            return "a"
        case .i:
            return "i"
        case .u:
            return "u"
        case .e:
            return "e"
        case .o:
            return "o"
        case .ka:
            return "ka"
        case .ki:
            return "ki"
        case .ku:
            return "ku"
        case .ke:
            return "ke"
        case .ko:
            return "ko"
        case .ga:
            return "ga"
        case .gi:
            return "gi"
        case .gu:
            return "gu"
        case .ge:
            return "ge"
        case .go:
            return "go"
        case .sa:
            return "sa"
        case .shi:
            return "shi"
        case .su:
            return "su"
        case .se:
            return "se"
        case .so:
            return "so"
        case .za:
            return "za"
        case .ji:
            return "ji"
        case .zu:
            return "zu"
        case .ze:
            return "ze"
        case .zo:
            return "zo"
        case .ta:
            return "ta"
        case .chi:
            return "chi"
        case .tsu:
            return "tsu"
        case .te:
            return "te"
        case .to:
            return "to"
        case .da:
            return "da"
        case .di:
            return "di"
        case .du:
            return "do"
        case .de:
            return "de"
        case .do:
            return "do"
        case .na:
            return "na"
        case .ni:
            return "ni"
        case .nu:
            return "nu"
        case .ne:
            return "ne"
        case .no:
            return "no"
        case .ha:
            return "ha"
        case .hi:
            return "hi"
        case .fu:
            return "fu"
        case .he:
            return "he"
        case .ho:
            return "ho"
        case .ba:
            return "ba"
        case .bi:
            return "bi"
        case .bu:
            return "bu"
        case .be:
            return "be"
        case .bo:
            return "bo"
        case .pa:
            return "pa"
        case .pi:
            return "pi"
        case .pu:
            return "pu"
        case .pe:
            return "pe"
        case .po:
            return "po"
        case .ma:
            return "ma"
        case .mi:
            return "mi"
        case .mu:
            return "mu"
        case .me:
            return "me"
        case .mo:
            return "mo"
        case .ya:
            return "ya"
        case .yu:
            return "yu"
        case .yo:
            return "yo"
        case .ra:
            return "ra"
        case .ri:
            return "ri"
        case .ru:
            return "ru"
        case .re:
            return "re"
        case .ro:
            return "ro"
        case .wa:
            return "wa"
        case .wo:
            return "wo"
        case .n:
            return "n"
        default:
            return rawValue
        }
    }
}
