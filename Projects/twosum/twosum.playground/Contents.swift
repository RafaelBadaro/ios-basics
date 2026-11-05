/*
 Given an array of integers nums and an integer target, return the indices of the two numbers that add up to target.
 Exactly one solution exists. You can’t use the same element twice.
 [2, 7, 11, 15], target 9 → [0, 1]
 */

//O(n2)
//Porque?
//pra cada item do array, voce compara com o resto
//Ou seja,
//passa uma vez (pra cada item...)
//e repassa de novo (compara com o resto...)

//O(1)
//Porque?
//“Tem alguma estrutura que cresce com o tamanho do input?”
//
//Nao! estamos apenas comparando e somando, sem estrutura nova
func twoSumBruteForce(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    for i in 0..<nums.count {
        let first = nums[i]
        let nextIndex = i+1
        // Aqui nao da crash, porque
        // na ultima iteracao:
        /// i = 3
        /// nextIndex = 4
        /// nums.count = 4
        /// 4..<4 -> isso não crasha, ele só não roda o loop!!!!
        ///
        for j in nextIndex..<nums.count {
            let second = nums[j]
            if first + second == target {
                return (i, j)
            }
        }
    }

    return nil
}

//if let result = twoSumBruteForce(nums, target) {
//    print(result)
//}

//O(n) -> passando pelo array 1 unica vez
//O(n) -> estamos crescendo um dict pra cada item do array
func twoSumWithDictionary(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    var dict = [Int: Int]()

    for (i, num) in nums.enumerated() {
        // Pega o complemento
        let complement = target - num

        // Ve se tem no dicionario antes
        if let complementIndex = dict[complement] {
            return (complementIndex, i)
        }
        // Se nao tiver, adiciona
        dict[num] = i
    }

    return nil
}


if let result = twoSumWithDictionary([3, 2, 4], 6) {
    print(result)
}
