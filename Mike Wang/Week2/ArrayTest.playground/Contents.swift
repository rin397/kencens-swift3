// Array
var array = [35,28,26,43]
print(array[1])
print(array.count)

// 新增一筆資料，在最後一筆
array.append(23)
// 移除指定的資料
array.remove(at: 4)
print(array)

var mixArray = ["Ken", 34, true] as [Any]

// 宣告一個字串陣列
var stringArray = [String]()

// 3.78 7.3 8.8 Remove 7.3 Append 3.78 * 8.8
var myArray = [3.78, 7.3, 8.8]
myArray.remove(at: 1)
myArray.append(myArray[0] * myArray[1])