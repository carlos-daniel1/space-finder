//
//  ViewModel.swift
//  space-finder
//
//  Created by Turma01-4 on 30/07/24.
//

import Foundation

let getUrl = "http://192.168.128.243:1880/get"
let postUrl = "http://192.168.128.243:1880/post"
let putUrl = "http://192.168.128.243:1880/put"

class ViewModel: ObservableObject {
    @Published var API = [Model]()
    
    func getData() {
        guard let url = URL(string: getUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {data, res, err in
         
            do {
                if let data = data {
                    
                    let result = try JSONDecoder().decode([Model].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.API = result
                    }
                    
                } else {
                    print("No data")
                }
                
                
            } catch (let error) {
                print(error.localizedDescription)
            }
            
            
        }.resume()
            
    }
    
    func postData(_ name: [String]) {
        guard let url = URL(string: postUrl) else { return }
        
        let bodyObject: [String: Any] = [:]
        let finalData = try! JSONSerialization.data(withJSONObject: bodyObject)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {data, res, err in
         
            do {
                if let data = data {
                    
                    let result = try JSONDecoder().decode([Model].self, from: data)
                    print(result)
                    
                    DispatchQueue.main.async {
                        self.API = result
                    }
                    
                } else {
                    print("No data")
                }
                
                
            } catch (let error) {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
    func putData() {
        guard let url = URL(string: putUrl) else { return }
        
        let bodyObject: [String: Any] = [:]
        let finalData = try! JSONSerialization.data(withJSONObject: bodyObject)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {data, res, err in
         
            do {
                if let data = data {
                    
                    let result = try JSONDecoder().decode([Model].self, from: data)
                    print(result)
                    
                    DispatchQueue.main.async {
                        self.API = result
                    }
                    
                } else {
                    print("No data")
                }
                
                
            } catch (let error) {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
}
