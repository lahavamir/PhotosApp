//
//  UploadLinkViewController.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import UIKit

class UploadLinkViewController: UIViewController {

    let model:LinkModel
    
    @IBOutlet weak var linkTableView: UITableView? {
        didSet{
            guard let linkTableView = linkTableView else { return }
            linkTableView.dataSource = self
            linkTableView.delegate = self
            linkTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    
    init(model:LinkModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.fetchLinks {[weak self] (finish) in
            self?.linkTableView?.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)


    }



}
