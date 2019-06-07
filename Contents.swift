//Author: Donitoshii

import UIKit

public class PaymentProccessor {

    fileprivate var batchSum : Double!{
        willSet{
            if (newValue > 0 && newValue > batchSum){
                print("\((newValue - batchSum).format()) enqueud into the batch, the updated batch value is: \(newValue!.format())")
            }
            defaults.set(newValue, forKey: "batch_sum")
        }
    }
    
    private var queue: Queue<Double>!
    private let BATCH_CAP: Double!
    private var defaults: UserDefaults!
    static public var shared = PaymentProccessor()
    
    init() {
        defaults = UserDefaults()
        queue = Queue<Double>()
        batchSum = defaults.value(forKey: "batch_sum") as? Double ?? 0.0
        BATCH_CAP = 0.50
    }

    
    private func shouldProcessBatch() -> Bool{
        guard batchSum < BATCH_CAP else {
            return true
        }
        return false
    }
    
    public func enqueue(transaction: Double){
        
        if(shouldProcessBatch()){
            processBatch()
            addToBatch(transaction: transaction)
        }else{
            addToBatch(transaction: transaction)
        }
    }
    
    private func addToBatch(transaction: Double) {
        queue.enqueue(element: transaction)
        batchSum += transaction
        
        if(shouldProcessBatch()){
            //procces batch
            processBatch()
        }else{
            defaults.set(batchSum, forKey: "batch_sum")
        }
    }
    
    func processBatch(){
        
        for _ in 0..<queue.getCount(){
            batchSum -= queue.peek()!
            print("deueuing \(queue.dequeue()!.format())")
            
        }
        print("deueuing \(batchSum!.format())")
        resetBatchSum()
    }
    
    func resetBatchSum(){
        batchSum = 0.0
        defaults.set(batchSum, forKey: "batch_sum")
    }
    
}

public extension Double {
    func format() -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedDouble = formatter.string(from: self as NSNumber)
        return formattedDouble!
    }
}


var transactionsDataSource1 = [0.32,0.10,0.01,0.02]
//var transactionsDataSource1 = [0.47]
var processor = PaymentProccessor()
for i in 0..<transactionsDataSource1.count {
    processor.enqueue(transaction: transactionsDataSource1[i])
}





