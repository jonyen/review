//
//  DetailViewController.swift
//  review
//
//  Created by Jonathan Yen on 11/16/14.
//  Copyright (c) 2014 Jonathan Yen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    var titleItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        self.automaticallyAdjustsScrollViewInsets = false
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.bodyText {
                label.text = detail.description
            }
        }
        if let detail: AnyObject = self.titleItem {
            if let label = self.titleText {
                label.text = detail.description

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

