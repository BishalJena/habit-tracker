//
//  Contact.swift
//  Contacts
//
//  Created by Mohamed Morad on 21/04/26.
//

import SwiftUI

struct Contact: Identifiable, Hashable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    var firstLetter: String {
        String(firstName.prefix(1))
    }
}


let richard = Contact(firstName: "Richard", lastName: "Feynman", phoneNumber: "+1 212 555 1234")
let adit = Contact(firstName: "Adit", lastName: "Sams", phoneNumber: "+62 812 3456 7890")
let arsene = Contact(firstName: "Arsene", lastName: "Wenger", phoneNumber: "+44 20 7946 0958")
let morad = Contact(firstName: "Morad", lastName: "Said", phoneNumber: "+1 415 555 2671")
let darma = Contact(firstName: "Darma", lastName: "Setiawan", phoneNumber: "+62 811 2345 6789")
let alice = Contact(firstName: "Alice", lastName: "Anderson", phoneNumber: "+1 (555) 000-0001")
let bob = Contact(firstName: "Bob", lastName: "Baker", phoneNumber: "+1 (555) 000-0002")
let charlie = Contact(firstName: "Charlie", lastName: "Chaplin", phoneNumber: "+1 (555) 000-0003")
let diana = Contact(firstName: "Diana", lastName: "Dover", phoneNumber: "+1 (555) 000-0004")
let edgar = Contact(firstName: "Edgar", lastName: "Ellis", phoneNumber: "+1 (555) 000-0005")
let fiona = Contact(firstName: "Fiona", lastName: "Fletcher", phoneNumber: "+1 (555) 000-0006")
let george = Contact(firstName: "George", lastName: "Gordon", phoneNumber: "+1 (555) 000-0007")
let hannah = Contact(firstName: "Hannah", lastName: "Hughes", phoneNumber: "+1 (555) 000-0008")
let ian = Contact(firstName: "Ian", lastName: "Irwin", phoneNumber: "+1 (555) 000-0009")
let julia = Contact(firstName: "Julia", lastName: "Jones", phoneNumber: "+1 (555) 000-0010")
let kevin = Contact(firstName: "Kevin", lastName: "Keller", phoneNumber: "+1 (555) 000-0011")
let linda = Contact(firstName: "Linda", lastName: "Lane", phoneNumber: "+1 (555) 000-0012")
let mark = Contact(firstName: "Mark", lastName: "Miller", phoneNumber: "+1 (555) 000-0013")
let nina = Contact(firstName: "Nina", lastName: "Nelson", phoneNumber: "+1 (555) 000-0014")
let oscar = Contact(firstName: "Oscar", lastName: "Owens", phoneNumber: "+1 (555) 000-0015")
let paula = Contact(firstName: "Paula", lastName: "Parker", phoneNumber: "+1 (555) 000-0016")
let quentin = Contact(firstName: "Quentin", lastName: "Quinn", phoneNumber: "+1 (555) 000-0017")
let rachel = Contact(firstName: "Rachel", lastName: "Reed", phoneNumber: "+1 (555) 000-0018")
let sam = Contact(firstName: "Sam", lastName: "Sanders", phoneNumber: "+1 (555) 000-0019")
let tina = Contact(firstName: "Tina", lastName: "Turner", phoneNumber: "+1 (555) 000-0020")
let umar = Contact(firstName: "Umar", lastName: "Upton", phoneNumber: "+1 (555) 000-0021")
let victor = Contact(firstName: "Victor", lastName: "Vargas", phoneNumber: "+1 (555) 000-0022")
let wendy = Contact(firstName: "Wendy", lastName: "Wells", phoneNumber: "+1 (555) 000-0023")
let xavier = Contact(firstName: "Xavier", lastName: "Xanders", phoneNumber: "+1 (555) 000-0024")
let yvonne = Contact(firstName: "Yvonne", lastName: "Young", phoneNumber: "+1 (555) 000-0025")
let zack = Contact(firstName: "Zack", lastName: "Zimmer", phoneNumber: "+1 (555) 000-0026")
let amelia = Contact(firstName: "Amelia", lastName: "Adams", phoneNumber: "+1 (555) 000-0027")
let brandon = Contact(firstName: "Brandon", lastName: "Brooks", phoneNumber: "+1 (555) 000-0028")
let cynthia = Contact(firstName: "Cynthia", lastName: "Coleman", phoneNumber: "+1 (555) 000-0029")
let diego = Contact(firstName: "Diego", lastName: "Diaz", phoneNumber: "+1 (555) 000-0030")
let elena = Contact(firstName: "Elena", lastName: "Esparza", phoneNumber: "+1 (555) 000-0031")
let farid = Contact(firstName: "Farid", lastName: "Fahmi", phoneNumber: "+62 812-3456-0032")
let giulia = Contact(firstName: "Giulia", lastName: "Galli", phoneNumber: "+39 333 000 0033")
let hana = Contact(firstName: "Hana", lastName: "Hasegawa", phoneNumber: "+81 90-0000-0034")
let ivan = Contact(firstName: "Ivan", lastName: "Ilyin", phoneNumber: "+7 900 000-0035")
let jose = Contact(firstName: "José", lastName: "Jiménez", phoneNumber: "+52 55 0000 0036")
let kate = Contact(firstName: "Kate", lastName: "Kowalski", phoneNumber: "+48 600 000 0037")
let li = Contact(firstName: "Li", lastName: "Wei", phoneNumber: "+86 138 0000 0038")
let malik = Contact(firstName: "Malik", lastName: "Musa", phoneNumber: "+234 800 000 0039")
let norah = Contact(firstName: "Norah", lastName: "Nasser", phoneNumber: "+971 50 000 0040")
let olivia = Contact(firstName: "Olivia", lastName: "O'Neil", phoneNumber: "+353 85 000 0041")
let pierre = Contact(firstName: "Pierre", lastName: "Petit", phoneNumber: "+33 6 00 00 00 42")
let qamar = Contact(firstName: "Qamar", lastName: "Qureshi", phoneNumber: "+92 300 0000043")
let rui = Contact(firstName: "Rui", lastName: "Ramos", phoneNumber: "+351 910 000 0044")
let sofia = Contact(firstName: "Sofia", lastName: "Silva", phoneNumber: "+34 600 000 0045")
let tom = Contact(firstName: "Tom", lastName: "Thompson", phoneNumber: "+44 7700 000046")
let ursula = Contact(firstName: "Ursula", lastName: "Ulrich", phoneNumber: "+49 160 000 0047")
let vinh = Contact(firstName: "Vinh", lastName: "Vo", phoneNumber: "+84 90 000 0048")
let wei = Contact(firstName: "Wei", lastName: "Wang", phoneNumber: "+65 8000 0049")
let xiao = Contact(firstName: "Xiao", lastName: "Xu", phoneNumber: "+86 139 0000 0050")
let yusuf = Contact(firstName: "Yusuf", lastName: "Yildiz", phoneNumber: "+90 530 000 0051")
let zoe = Contact(firstName: "Zoe", lastName: "Zane", phoneNumber: "+1 (555) 000-0052")

let mockContacts: [Contact] = [
    richard, adit, arsene, morad, darma,
    alice, bob, charlie, diana, edgar, fiona, george, hannah, ian, julia,
    kevin, linda, mark, nina, oscar, paula, quentin, rachel, sam, tina,
    umar, victor, wendy, xavier, yvonne, zack,
    amelia, brandon, cynthia, diego, elena, farid, giulia, hana, ivan, jose,
    kate, li, malik, norah, olivia, pierre, qamar, rui, sofia, tom, ursula,
    vinh, wei, xiao, yusuf, zoe
]
