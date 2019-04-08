//
//  UploadLinkViewController + delegate.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

extension UploadLinkViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let urlText:String = cell.textLabel?.text, let url = URL(string: urlText) else {
            return
        }
        
        // open native safari app at image url
        openSafari(at: url)
    }
    
    func openSafari(at url:URL)
    {
        // safari app
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
