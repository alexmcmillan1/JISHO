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
    case kataa = "ア"
    case katai = "イ"
    case katau = "ウ"
    case katae = "エ"
    case katao = "オ"
    case kataka = "カ"
    case kataki = "キ"
    case kataku = "ク"
    case katake = "ケ"
    case katako = "コ"
    case kataga = "ガ"
    case katagi = "ギ"
    case katagu = "グ"
    case katage = "ゲ"
    case katago = "ゴ"
    case katasa = "サ"
    case katashi = "シ"
    case katasu = "ス"
    case katase = "セ"
    case kataso = "ソ"
    case kataza = "ザ"
    case kataji = "ジ"
    case katazu = "ズ"
    case kataze = "ゼ"
    case katazo = "ゾ"
    case katata = "タ"
    case katachi = "チ"
    case katatsu = "ツ"
    case katate = "テ"
    case katato = "ト"
    case katada = "ダ"
    case katadi = "ヂ"
    case katadu = "ヅ"
    case katade = "デ"
    case katado = "ド"
    case katana = "ナ"
    case katani = "ニ"
    case katanu = "ヌ"
    case katane = "ネ"
    case katano = "ノ"
    case kataha = "ハ"
    case katahi = "ヒ"
    case katafu = "フ"
    case katahe = "ヘ"
    case kataho = "ホ"
    case kataba = "バ"
    case katabi = "ビ"
    case katabu = "ブ"
    case katabe = "ベ"
    case katabo = "ボ"
    case katapa = "パ"
    case katapi = "ピ"
    case katapu = "プ"
    case katape = "ペ"
    case katapo = "ポ"
    case katama = "マ"
    case katami = "ミ"
    case katamu = "ム"
    case katame = "メ"
    case katamo = "モ"
    case kataya = "ヤ"
    case katayu = "ユ"
    case katayo = "ヨ"
    case katara = "ラ"
    case katari = "リ"
    case kataru = "ル"
    case katare = "レ"
    case kataro = "ロ"
    case katawa = "ワ"
    case katawo = "ヲ"
    case katan = "ン"
    case katadoubleNextConsonant = "ッ"
    case katasmallYa = "ャ"
    case katasmallYu = "ュ"
    case katasmallYo = "ョ"
    
    var isSmallModifier: Bool {
        return [Kana.smallYa, Kana.smallYu, Kana.smallYo, Kana.katasmallYa, Kana.katasmallYo, Kana.katasmallYo].contains(self)
    }
    
    var smallModifierRomaji: String {
        switch self {
        case .smallYa: return Kana.ya.romaji
        case .smallYu: return Kana.yu.romaji
        case .smallYo: return Kana.yo.romaji
        case .katasmallYa: return Kana.kataya.romaji
        case .katasmallYu: return Kana.katayu.romaji
        case .katasmallYo: return Kana.katayo.romaji
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
        case .kataa:
            return "a"
        case .katai:
            return "i"
        case .katau:
            return "u"
        case .katae:
            return "e"
        case .katao:
            return "o"
        case .kataka:
            return "ka"
        case .kataki:
            return "ki"
        case .kataku:
            return "ku"
        case .katake:
            return "ke"
        case .katako:
            return "ko"
        case .kataga:
            return "ga"
        case .katagi:
            return "gi"
        case .katagu:
            return "gu"
        case .katage:
            return "ge"
        case .katago:
            return "go"
        case .katasa:
            return "sa"
        case .katashi:
            return "shi"
        case .katasu:
            return "su"
        case .katase:
            return "se"
        case .kataso:
            return "so"
        case .kataza:
            return "za"
        case .kataji:
            return "ji"
        case .katazu:
            return "zu"
        case .kataze:
            return "ze"
        case .katazo:
            return "zo"
        case .katata:
            return "ta"
        case .katachi:
            return "chi"
        case .katatsu:
            return "tsu"
        case .katate:
            return "te"
        case .katato:
            return "to"
        case .katada:
            return "da"
        case .katadi:
            return "di"
        case .katadu:
            return "do"
        case .katade:
            return "de"
        case .katado:
            return "do"
        case .katana:
            return "na"
        case .katani:
            return "ni"
        case .katanu:
            return "nu"
        case .katane:
            return "ne"
        case .katano:
            return "no"
        case .kataha:
            return "ha"
        case .katahi:
            return "hi"
        case .katafu:
            return "fu"
        case .katahe:
            return "he"
        case .kataho:
            return "ho"
        case .kataba:
            return "ba"
        case .katabi:
            return "bi"
        case .katabu:
            return "bu"
        case .katabe:
            return "be"
        case .katabo:
            return "bo"
        case .katapa:
            return "pa"
        case .katapi:
            return "pi"
        case .katapu:
            return "pu"
        case .katape:
            return "pe"
        case .katapo:
            return "po"
        case .katama:
            return "ma"
        case .katami:
            return "mi"
        case .katamu:
            return "mu"
        case .katame:
            return "me"
        case .katamo:
            return "mo"
        case .kataya:
            return "ya"
        case .katayu:
            return "yu"
        case .katayo:
            return "yo"
        case .katara:
            return "ra"
        case .katari:
            return "ri"
        case .kataru:
            return "ru"
        case .katare:
            return "re"
        case .kataro:
            return "ro"
        case .katawa:
            return "wa"
        case .katawo:
            return "wo"
        case .katan:
            return "n"
        default:
            return rawValue
        }
    }
}
