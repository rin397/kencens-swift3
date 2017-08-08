// Check String
let name = "Mike"

if name == "Mike" {
    print("Hi \(name) You can play!")
} else {
    print("Sorry \(name) You can not play")
}

// Check number
let age = 18
if age >= 18 {
    print("You can play!")
} else {
    print("You can not play!")
}

// And
if name == "Mike" && age >= 18 {
    print("You can play")
} else if name == "Mike" {
    print("Sorry Mike, you need to get order")
}

// Or
if name == "Mike" || name == "Tommy" {
    print("Welcome \(name)")
}

// Boolean And If
let isMale = true
if isMale {
    print("You are male!")
} else {
    print("")
}