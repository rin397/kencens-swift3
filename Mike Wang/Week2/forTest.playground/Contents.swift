// for
var array = [8,24,99,2,1,789]

for number in array {
    print(number)
}

// 4 name array, print Hi...
let names = ["Ken", "Jimmy", "Tom", "John"]

for name in names {
    print("Hi \(name)")
}

var numbers = [7,2,9,4,1]

for (index, value) in numbers.enumerated() {
    numbers[index] += 1
}
print(numbers)

// 8 9 17 28
var myArray = [Double]()
myArray = [8,9,17,28]
for (index, value) in myArray.enumerated() {
    myArray[index] = value / 2
}
print(myArray)