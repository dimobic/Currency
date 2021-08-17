//
//  model.swift
//  Currency
//
//  Created by Dima Chirukhin on 13.08.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit

class currency  {
    var NumCode : String?
    var CharCode : String?
    
    var Nominal : String?
    var nNominal : Double?
    
    var Name :String?
    
    var Value : String?
    var nValue : Double?
    
    var imagef: UIImage?{
        if let CharCode = CharCode {
            return UIImage(named: "flags/"+CharCode+".png")
        }
        return nil
    }
    class func rub() -> currency {
        let r = currency()
        r.CharCode = "RUR"
        r.Name = "Рубль"
        r.nNominal = 1
        r.Nominal = "1"
        //r.NumCode = ""
        r.nValue = 1
        r.Value = "1"
        return r
    }
}

class model: NSObject, XMLParserDelegate {
    static let shared = model()
    var currencies : [currency] = []
    var curdata : String = ""
    
    var from : currency = currency.rub()
    var to :currency = currency.rub()
    
    func convert (amount : Double?) -> String {
        if amount == nil{
            return " "
        }
        let d =  ((from.nNominal! * from.nValue!) / (to.nNominal! * to.nValue!)) * amount!
        return String(d)
    }
    
    var pathXML :String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) [0] + "/data.xml"
        if FileManager.default.fileExists(atPath: path)
        {
            return path
        }
        return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    var urlXML :URL?{
        print(URL(fileURLWithPath: pathXML))
        return URL(fileURLWithPath: pathXML)
    }
    
   func LoadXML (data: Date?) {
        
        var strurl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        if data  != nil{
            let datemat = DateFormatter()
            datemat.dateFormat = "dd/MM/yyy"
            strurl = strurl+datemat.string(from: data!)
        }
    var erg : String?
        let url = URL(string: strurl)
        if data != nil{
            
        }
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error == nil{
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) [0] + "/data.xml"
                let urlSave = URL(fileURLWithPath: path)
                do{
                    try data?.write(to: urlSave)
                    print("загружен")
                    self.parse()
                } catch{
                    print(error.localizedDescription)
                    erg = error.localizedDescription
                }
            }
            else{
                print(error!.localizedDescription)
                erg = error?.localizedDescription
            }
            if  let erg = erg {
                NotificationCenter.default.post(name: NSNotification.Name("error"), object: self, userInfo: ["name":erg])
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("start"), object: self)
        task.resume()
    }
    
    func parse()  {
        currencies = [currency.rub()]
        let parser = XMLParser(contentsOf: urlXML!)
        parser?.delegate = self
        parser?.parse()
        print("not")
        NotificationCenter.default.post(name: NSNotification.Name("data"), object: self)
        for c in currencies{
            if c.CharCode == from.CharCode{
                from = c
            }
            if c.CharCode == to.CharCode{
                to = c
            }
        }
    }
    var curCurrency :currency?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        if elementName == "ValCurs" {
            if  let curdatastr = attributeDict["Date"]{
                curdata = curdatastr
            }
            
        }
        
        
        if elementName == "Valute" {
            curCurrency = currency()
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
      
        if elementName == "NumCode" {
            curCurrency?.NumCode = curChar      }
        if elementName == "CharCode" {
            curCurrency?.CharCode = curChar        }
        if elementName == "Nominal" {
            curCurrency?.Nominal = curChar
            curCurrency?.nNominal = Double(curChar)
        }
        if elementName == "Name" {
            curCurrency?.Name = curChar        }
        if elementName == "Value" {
            curCurrency?.Value = curChar
            curCurrency?.nValue = Double(curChar.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Valute" {
            currencies.append( curCurrency! )}
    }
/*
     <ValuteID="R01010">
     <NumCode>036</NumCode>
     <CharCode>AUD</CharCode>
     <Nominal>1</Nominal>
     <Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
     <Value>16,0102</Value>
     */
    var curChar: String = ""
    func parser(_ parser: XMLParser, foundCharacters string: String){
        curChar = string
        
    }
    
}






