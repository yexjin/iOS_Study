//
//  TodoListViewController.swift
//  TodoList
//
//  Created by 오예진 on 2022/08/15.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var isTodayButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

