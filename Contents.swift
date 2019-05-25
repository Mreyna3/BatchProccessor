import UIKit

public class PaymentProccessor {
    
    //private variables
    internal var batchSum : Double!{
        willSet{
            if (newValue > 0 && newValue > batchSum){
                print("Transaction enqueud into the batch, the updated batch value is: \(newValue!)")
            }
        }
    }
    
    public var _donation: Double!
    public var queue: Queue<Double>!
    
    //public variables
    let BATCH_CAP: Double!
    static public var shared = PaymentProccessor()
    
    init() {
        let defaults = UserDefaults()
        queue = Queue<Double>()
        batchSum = defaults.value(forKey: "batch_sum") as? Double ?? 0.0
        BATCH_CAP = 0.50
    }
    
    private func addToBatch(donationAmount: Double) {
        queue.enqueue(element: donationAmount)
        batchSum += donationAmount
        
        if(shouldProcessBatch()){
            //procces batch
            processBatch()
        }else{
            let defaults = UserDefaults()
            defaults.set(batchSum, forKey: "batch_sum")
        }
    }
    
    func shouldProcessBatch() -> Bool{
        if (batchSum >= BATCH_CAP){
            return true
        }else{
            return false
        }
    }
    
    public func enqueueDonation(donation: Double){
        _donation = donation
        
        if(shouldProcessBatch()){
            processBatch()
            addToBatch(donationAmount: _donation)
        }else{
            addToBatch(donationAmount: _donation)
        }
        
    }
    
    func processBatch(){
        let formattedDonationAmount = formatDonationAmount(donationtAmount: batchSum)
        
        for _ in 0..<queue.getCount(){
            batchSum -= queue.peek()!
            print("deueuing \(queue.dequeue())")
            
        }
        print("deueuing \(batchSum)")
        resetBatchSum()
    }
    
    func resetBatchSum(){
        let defaults = UserDefaults()
        batchSum = 0.0
        defaults.set(batchSum, forKey: "batch_sum")
    }
    
    func formatDonationAmount(donationtAmount: Double) -> String{
        let roundedDonation = Int(donationtAmount.rounded(toPlaces: 2) * 100)
        let stripeFormattedDonation = String(format: "%04d", roundedDonation)
        return stripeFormattedDonation
    }
    
}

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



var transactionsDataSource1 = [0.32,0.10,0.01,0.02]

var processor = PaymentProccessor()
for i in 0..<transactionsDataSource1.count {
    processor.enqueueDonation(donation: transactionsDataSource1[i])
}


print(processor.batchSum)

