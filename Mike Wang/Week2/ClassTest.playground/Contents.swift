class Enemy {
    var isAlive = true
    var strength = 9
    
    func kill() {
        isAlive = false
    }
    func isStrong() -> Bool {
        if strength > 10 {
            return true
        } else {
            return false
        }
    }
}

var enemy = Enemy()
print(enemy.isAlive)
enemy.strength = 20
print(enemy.strength)
enemy.kill()
print(enemy.isStrong())



