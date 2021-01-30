
TestGeneral = Test:NewSuite({['Name'] = 'AuxiliaryFunctions/General'})

--  ========
--  IS VALID
--  ========

TestGeneral.It({
    description = 'Should return false for nil',
    fun = IsValid,
    params = {[1] = nil},
    expectation = {[1] = false}
})
TestGeneral.It({
    description = 'Should return false for 0',
    fun = IsValid,
    params = {[1] = 0},
    expectation = {[1] = false}
})
TestGeneral.It({
    description = 'Should return true for 1',
    fun = IsValid,
    params = {[1] = 1},
    expectation = {[1] = true}
})
TestGeneral.It({
    description = 'Should return false for empty string',
    fun = IsValid,
    params = {[1] = ""},
    expectation = {[1] = false}
})
TestGeneral.It({
    description = 'Should return false for empty table',
    fun = IsValid,
    params = {[1] = 0},
    expectation = {[1] = false}
})
TestGeneral.It({
    description = 'Should return true for function',
    fun = IsValid,
    params = {[1] = function() return 'Test' end},
    expectation = {[1] = true}
})

TestGeneral:Results()