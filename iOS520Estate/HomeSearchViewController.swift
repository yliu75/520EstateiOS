//
//  HomeSearchViewController.swift
//  iOS520Estate
//
//  Created by Yonglun Liu on 2017/8/27.
//  Copyright © 2017年 YonglunTech. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate=self
        SearchBar.becomeFirstResponder()
        self.view.backgroundColor=globalBackgroundColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
