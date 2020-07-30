//
//  HelpVC.swift
//  Weather
//
//  Created by Illya Kuznietsov on 30.07.2020.
//  Copyright © 2020 _. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            guard let filePath = Bundle.main.path(forResource: "help", ofType: "html")
                else {
                    print ("File reading error")
                    return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
    
    
}
