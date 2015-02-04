import Foundation

class Position: Printable {
    let col: Int
    let row: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    var description: String {
        return NSString(format: "Position row: %d, col: %d", self.row, self.col)
    }
}