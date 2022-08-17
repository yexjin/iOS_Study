//
//  Storage.swift
//  TodoList
//
//  Created by 오예진 on 2022/08/15.
//

import Foundation

public class Storage {
    
    private init() { }
    
    
    // TODO: FileManager을 통해, 앱 공간을 관리!
    enum Directory {
        case documents
        case caches
        
        var url: URL {
            let path: FileManager.SearchPathDirectory
            switch self {
            case .documents:
                path = .documentDirectory
            case .caches:
                path = .cachesDirectory
            }
            return FileManager.default.urls(for: path, in: .userDomainMask).first!
        }
    }
    
    
    // TODO: store 로직
    // Cadable encode : JSON 타입으로
    static func store<T: Encodable>(_ obj: T, to directory: Directory, as fileName: String) {
        
        // appendingPathComponent : 경로를 새롭게 추가
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> save to here: \(url)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted   // 출력 줄바꿈 설정
        
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
        
    }
    
    
    
    // TODO: retrive 로직
    // 파일을 Data 타입 형태로 읽기
    // Codable decode : Data 타입으로
    static func retreive<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(type, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    // TODO: remove 로직
    static func remove(_ fileName: String, from directory: Directory) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("---> Failed to remove msg: \(error.localizedDescription)")
        }
        
    }
    
    
    // TODO: clear 로직
    static func clear(from directory: Directory) {
        let url = directory.url
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])   // contents 안에는 파일리스트가 배열로 들어가게 됨.
            for content in contents {   // 하나하나 다 지워!
                try FileManager.default.removeItem(at: content)
            }
        } catch {
            print("---> Failed to clear directory ms: \(error.localizedDescription)")
        }
    }
    
    
}


// MARK: TEST 용
extension Storage {
    static func saveTodo(_ obj: Todo, fileName: String) {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> [TEST] save to here: \(url)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
         
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
    }

    
    
    static func restoreTodo(_ fileName: String) -> Todo? {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(Todo.self, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
}

