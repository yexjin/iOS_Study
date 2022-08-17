//
//  Todo.swift
//  TodoList
//
//  Created by 오예진 on 2022/08/15.
//

import UIKit

// TODO: Codable과 Equatable 프로토콜 추가
// Codable : JSON 파일을 Swift가 알아들을 수 있게 바꿔줌
// Equatable : 여기서는 '=='의 조건을 정의해 줄 수 있음( 값이 동등한지 ), 사용자가 손쉽게 정의할 수 있도록 해줌
struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    // 구조제에 선언된 프로퍼티를 변경하기 위해서는 함수앞에 mutating 키워드 붙여주기
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        //값타입인 struct는 속성을 인스턴스 메서드 내에서 수정할 수 없음
        // 수정하려면 mutating 키워드 추가
        // TODO: update 로직 추가
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
}

class TodoManager {
    
    static let shared = TodoManager()
    
    static var lastId: Int = 0
    
    var todos: [Todo] = []
    
    // TODO: create 로직 추가
    func createTodo(detail: String, isToday: Bool) -> Todo {
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        
        return Todo(id: nextId, isDone: false, detail: detail, isToday: isToday)    // 왜 isToday는 Bool 값으로 안주지?
    }
    
    // TODO: add 로직 추가
    func addTodo(_ todo: Todo) {
        todos.append(todo)
        saveTodo()
    }
    
    // TODO: delete 로직 추가
    func deleteTodo(_ todo: Todo) {
        todos = todos.filter{ $0.id != todo.id }
        saveTodo()
    }
    
    // TODO: update 로직 추가
    func updateTodo(_ todo: Todo) {
        // firstIndex(of:) 는 배열의 앞에서부터 조회해서 todo와 첫번째 일치하는 값의 index를 반환
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    // TODO: save 로직 추가
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todo.json")
    }
    
    // TODO: retrieve 로직 추가
    func retrieveTodo() {
        todos = Storage.retreive("todo.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        
        TodoManager.lastId = lastId
    }
}

class TodoViewModel {
    
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
            case .today: return "Today"
            default: return "Upcoming"
            }
        }
    }
    
    private let manager = TodoManager.shared
    
    var todos: [Todo] {
        return manager.todos
    }
    
    var todayTodos: [Todo] {
        return todos.filter { $0.isToday == true }
    }
    
    var upcompingTodos: [Todo] {
        return todos.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addTodo(_ todo: Todo) {
        manager.addTodo(todo)
    }
    
    func deleteTodo(_ todo: Todo) {
        manager.deleteTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        manager.updateTodo(todo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
}
