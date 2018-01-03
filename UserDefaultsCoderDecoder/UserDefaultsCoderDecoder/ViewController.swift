//
//  ViewController.swift
//  UserDefaultsCoderDecoder
//
//  Created by Gmo Ginppian on 02/01/18.
//  Copyright © 2018 BUAP. All rights reserved.
//

import UIKit

class Persona: NSObject, NSCoding {
    
    var nombre: String = String()
    var apellido: String = String()
    var edad: Int = Int()
    
    // Inicializamos herencia 
    override init() {
         super.init()
    }
    
    // Decoder
    //required init(coder decoder: NSCoder) {}
    required init(coder aDecoder: NSCoder) {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as? String ?? ""
        self.apellido = aDecoder.decodeObject(forKey: "apellido") as? String ?? ""
        //list for > swift 3 and for < swift 3 you can user decodeObject, font: developer.apple.com/reference/foundation/nscoder, for both:
        self.edad = aDecoder.decodeObject(forKey: "edad") as? Int ??  aDecoder.decodeInteger(forKey: "edad")
    }
    
    // Encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(apellido, forKey: "apellido")
        aCoder.encode(edad, forKey: "edad")
    }
    
    override var description: String {
        return "\(self.nombre)\n\(self.apellido)\n\(self.edad)"
    }

}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Creamos una persona
        let p = Persona()
        p.nombre = "memo"
        p.apellido = "alonso"
        p.edad = 100
        
        // Intentamos persistirla
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: p)
        UserDefaults.standard.set(encodedData, forKey: "keyPerson")
        
        // Intentamos recuperarla
        if let data = UserDefaults.standard.data(forKey: "keyPerson"),
            let myPerson = NSKeyedUnarchiver.unarchiveObject(with: data) as? Persona {
            print(myPerson)
        } else {
            print("Some bug 🐞🐛")
        }
    }

}

