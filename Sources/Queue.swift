//Author: Donny-Hack

import Foundation

public struct Queue<T> {
    
    private var dataSource  = [T]()
    public init() {}
    
    
    public func isEmpty() -> Bool{
      
        return  dataSource.isEmpty
    }
    
    public mutating func enqueue( element: T){
        dataSource.append(element)
    }
    
   public mutating func dequeue() -> T?{
        return isEmpty() ? nil : dataSource.removeFirst()
    }
    
    public func peek() -> T? {
        return isEmpty() ? nil : dataSource.first
    }
    
    public func getCount() -> Int {
        return dataSource.count
    }
    
    public func printQueue(){
       print(dataSource)
    }
}

    
    





