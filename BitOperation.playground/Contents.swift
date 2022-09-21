import UIKit
/*:
 # Bit Operation
 定量整數可以用「二進位、八進位、十六進位」來 init
 
 ## Bit Operation Operator
 Swift 提供了：
 - NOT(~(单目运算符))
 ![NOT](bitwiseNOT_2x.png)
 - AND(运算符为 &)
 ![AND](bitwiseAND_2x.png)
 - OR(运算符为|)
 ![OR](bitwiseOR_2x.png)
 - XOR(运算符为 ^) 相同 0, 不同為 1
 ![XOR](bitwiseXOR_2x.png)
 - 左移 <<
 - 右移 >>
 ### unsigned shift
 ![unsigned shift](bitshiftUnsigned_2x.png)
 ### signed shift
 有符號整數使用它們的第一位（稱為符號位）來指示整數是正還是負。
 符號位0表示正數，符號1表示負數。
 
 ### positive signed integer
 正數以與無符號整數完全相同的方式存儲，從0向上計數。
 ![bitshiftSignedFour_2x](bitshiftSignedFour_2x.png)
 
 
 ### negative singed integer
 負數以不同方式存儲。它們的存儲方式是將它們的絕對值減去2的n次方，其中n是值的位數。
 簡單地通過執行一個標準二進制加法全部八個位（包括符號位），並丟棄任何不適合8位
 ![bitshiftSignedAddition_2x](bitshiftSignedAddition_2x.png)
 
 ![bitshiftSignedMinusFour_2x](bitshiftSignedMinusFour_2x.png)
 
 
 [Reference](https://swift.gg/2016/03/30/Dealing-With-Bit-Sets-In-Swift/)
*/

extension FixedWidthInteger {
    var binaryText: String {
        let binaryText = String(self, radix: 2)
        return binaryText
    }
}
// MARK: - NOT (~)
let initialBits: UInt8 = 0b00001111
let convertedBits = ~initialBits
convertedBits.binaryText

// MARK: - AND ( & )
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits
middleFourBits.binaryText

// MARK: - OR ( | )
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits
combinedBits.binaryText

// MARK: - XOR ( ^ )
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits
outputBits.binaryText

// MARK: - shift << , >>
let shiftBits: UInt8 = 4
shiftBits.binaryText
(shiftBits << 1).binaryText
(shiftBits << 2).binaryText
(shiftBits << 5).binaryText
(shiftBits << 6).binaryText
(shiftBits >> 1).binaryText
(shiftBits >> 2).binaryText
(shiftBits >> 5).binaryText
(shiftBits >> 6).binaryText

// MARK: - Shift to decode and parse value
let pink: UInt32 = 0xCC6699 // r:204, g:102, b:153
let red = (pink & 0xFF0000) >> 16
red.binaryText
let green = (pink & 0x00FF00) >> 8
green.binaryText
let blue = pink & 0x0000FF

// MARK: - Practice
var int1:UInt8 = 0b10101010 // 1 * 2^7 + 1 * 2^5 + 1 * 2^3 + 1 * 2^1
var int2:UInt8 = 0o55 // 5 * 8^1 + 5 * 8^0
var int3:UInt8 = 0xA7 // 10 * 16^1 + 7 * 16^0

var u8: UInt8 = 1
u8 << 2  // 4            //4: 数字 2 被认为是 UInt8 类型，u8
int1 << 2 // 左移兩個 bit，但因爲 UInt8 只有 8 個 bit ，所以變成 10101000 -> 168
int3.binaryText
int3 << 2 // 左移兩個 bit，但因爲 UInt8 只有 8 個 bit ，所以變成 10011100 -> 156
var final = 0b10011100

var by2: Int16 = 1
u8 << by2
u8 << UInt8(by2)     //2: 这是可行的，我们手动转换了整型的类型，
                  
var statusFlags: UInt8 = 0b00000100

// check if the 3rd flag is one (value equals to 4)
print(statusFlags & 0b00000100 == 4)   // true

// check if the 5th flag is one (value equals to 16)
print(statusFlags & 0b00010000 == 16)  // false

// set the 5th flag to 1
statusFlags = statusFlags & 0b11101111 | 16
print(statusFlags.binaryText)  // 00010100

// set the 3rd flag to zero
statusFlags = statusFlags & 0b11111011 | 0
print(statusFlags.binaryText) // 00010000

// set the 5th flag back to zero
statusFlags = statusFlags & 0b11101111 | 0
print(statusFlags.binaryText) // 00000000

// set the 3rd flag back to one
statusFlags = statusFlags & 0b11101011 | 4
print(statusFlags.binaryText) // 00000100


var registrationNumber = 74656
var dataForRegistrationNumber: [UInt8] = [160,35,1]
let data2 = Data(dataForRegistrationNumber)
print("data2: \(data2)")
data2.withUnsafeBytes { pointerBuffer in
    pointerBuffer.map{ $0 }
}

let value: Int32 = -1333
extension FixedWidthInteger {
    var data: Data {
        let data = withUnsafeBytes(of: self) { Data($0) }
        return data
    }
}
value.data
let value2 = -1333
value2.data
let array2 = withUnsafeBytes(of: value.littleEndian, Array.init)
let array = withUnsafeBytes(of: registrationNumber.littleEndian, Array.init)
print(array) // [255, 255, 250, 203]
withUnsafeBytes(of: registrationNumber) { pointerBuffer in
    for (index, byte) in pointerBuffer.enumerated() {
        print("\(index): \(byte)")
    }
}
