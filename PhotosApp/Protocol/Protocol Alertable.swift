//
//  Protocol Alertable.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit


// make any uiviewcontroller alertable
protocol Alertable {
    
    func alert(title:String, body:String, actionTitle:String, handler: ((UIAlertAction) -> ())?)
}

extension Alertable where Self:UIViewController
{
    func alert(title:String, body:String, actionTitle:String, handler: ((UIAlertAction) -> ())?)
    {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    
}
