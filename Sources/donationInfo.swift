public struct DonationInfo:Codable {
    
    public let amount: Double?
    public let date: String?
    public let destination: String?
    public let source: String?
    public let metadata: String?
    
    public init() {
        amount = 0
        date = ""
        destination = ""
        source = ""
        metadata = ""
    }
    
    public init(_amount: Double?, _date: String?,_destination: String?,_source: String?, _metadata: String?){
        self.amount = _amount!
        self.date = _date!
        self.destination = _destination!
        self.source = _source!
        self.metadata = _metadata!
    }
}

public struct Transaction: Codable{
    public let amount: Double?
    public let date: String?
    public let destination: String?
    public let source: String?
    
    public init(amount: Double!, date: String!, destination: String!, source: String!){
        self.amount = amount!
        self.date = date!
        self.destination = destination!
        self.source = source!
     
    }
}
