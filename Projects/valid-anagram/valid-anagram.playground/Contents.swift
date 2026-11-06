/*
 Valid Anagram

 Dadas duas strings s e t, retorna true se t é um anagrama de s, ou seja, se tem exatamente as mesmas letras, na mesma quantidade, só que em outra ordem.

 As strings têm só letras minúsculas (a–z)
 Tamanhos diferentes → já é false
 */

func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    return s.sorted() == t.sorted()
}

//print(isAnagram("anagram", "nagaram"))  // esperado: true
//print(isAnagram("rat", "car"))          // esperado: false
//print(isAnagram("ab", "a"))             // esperado: false
//print(isAnagram("aacc", "ccac"))        // esperado: false (mesmas letras, quantidades diferentes)


func isAnagramCounting(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }

    var dict = [Character: Int]()

    for char in s {
        dict[char, default: 0] += 1
    }

    for char in t {
        dict[char, default: 0] -= 1
    }

    let foundInvalidValue = dict.values.first { $0 != 0 }

    // ou "return dict.values.allSatisfy { $0 == 0 }"
    return foundInvalidValue == nil
}

print(isAnagramCounting("anagram", "nagaram"))  // esperado: true
print(isAnagramCounting("rat", "car"))          // esperado: false
print(isAnagramCounting("ab", "a"))             // esperado: false
print(isAnagramCounting("aacc", "ccac"))        // esperado: false (mesmas letras, quantidades diferentes)
