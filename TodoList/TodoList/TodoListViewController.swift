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
    
    // TODO: TodoViewModel 만들기
    let todoListViewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // TODO: Todo 데이터 불러오기
        todoListViewModel.loadTasks()
        
        let todo = TodoManager.shared.createTodo(detail: "따따봉", isToday: true)

        Storage.saveTodo(todo, fileName: "test.json")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let todo = Storage.restoreTodo("test.json")
        print("restore form disck \(todo)")
        
    }
    
    @IBAction func isTodayButtonTapped(_ sender: Any) {
        // TODO: 투데이 버튼 토글 작업
        
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        // TODO: Todo 태스크 추가
        
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        let todo = TodoManager.shared.createTodo(detail: detail, isToday: isTodayButton.isSelected)
        
        todoListViewModel.addTodo(todo) // view model에 task를 추가하고
        collectionView.reloadData() // collectionView에 reload or update
        inputTextField.text = ""
        isTodayButton.isSelected = false
    }
    
    @IBAction func tapBG(_ sender: Any) {
        // TODO: Background를 tap 했을 때, 키보드 내려오게 하기
    
        inputTextField.resignFirstResponder()
    }
    
}

extension TodoListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: 섹션 몇개
        return todoListViewModel.numOfSection
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 섹션별 아이템 몇개
        if section == 0{
            return todoListViewModel.todayTodos.count
        }else{
            return todoListViewModel.upcompingTodos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: 커스텀 셀
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoListCell", for: indexPath) as? TodoListCell else {
            return UICollectionViewCell()
        }
        
        var todo : Todo
        if indexPath.section == 0 {
            todo = todoListViewModel.todayTodos[indexPath.item]
        }else {
            todo = todoListViewModel.upcompingTodos[indexPath.item]
        }
        
        cell.updateUI(todo: todo)
        
        
        cell.doneButtonTapHandler = { isDone in
            todo.isDone = isDone
            self.todoListViewModel.updateTodo(todo)
            self.collectionView.reloadData()
        }
        cell.deleteButtonTapHandler = {
            self.todoListViewModel.deleteTodo(todo)
            self.collectionView.reloadData()
        }
        
        
        
        return cell
    }
    
    //헤더뷰
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodoListHeaderView", for: indexPath) as? TodoListHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = TodoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.sectionTitleLabel.text = section.title
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension TodoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: 사이즈 계산하기
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat =  50
        return CGSize(width: width, height: height)
    }
}

class TodoListHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


class TodoListCell: UICollectionViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var strikeThroughView: UIView!
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    
    func updateUI(todo: Todo) {
        // TODO: Todo Cell 업데이트
        checkButton.isSelected = todo.isDone
        descriptionLabel.text = todo.detail
        descriptionLabel.alpha = todo.isDone ? 0.2 : 1
        deleteButton.isHidden = todo.isDone == false
        showStrikeThrough(todo.isDone)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func showStrikeThrough(_ show: Bool) {
        if show {
            strikeThroughWidth.constant = descriptionLabel.bounds.width
        } else {
            strikeThroughWidth.constant = 0
        }
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        // TODO: CheckButton 처리
        checkButton.isSelected = !checkButton.isSelected
        let isDone = checkButton.isSelected
        showStrikeThrough(isDone)
        descriptionLabel.alpha = isDone ? 0.2 : 1
        deleteButton.isHidden = !isDone
        doneButtonTapHandler?(isDone)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
    
    func reset() {
        // TODO: reset로직 구현
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false)
    }
}
