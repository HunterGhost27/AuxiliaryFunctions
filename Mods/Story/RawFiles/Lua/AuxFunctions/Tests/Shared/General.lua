--  =======
--  IMPORTS
--  =======

require('Mods.Story.RawFiles.Lua.AuxFunctions.Shared.General')  --  Test File

-- Dependencies
require('Mods.Story.RawFiles.Lua.AuxFunctions.Shared.Strings')
require('Mods.Story.RawFiles.Lua.AuxFunctions.Shared.Tables')

--  =======
--  GENERAL
--  =======

Lust.describe('General', function ()

    --  IS-VALID
    --  ========

    Lust.describe('IsValid', function ()
    
        Lust.it('should return false for nil', function ()
            Lust.expect(IsValid(nil)).to_not.be.truthy()
            Lust.expect(IsValid(nil)).to.exist()
            Lust.expect(IsValid(nil)).to_not.be(nil)
        end)
    
        Lust.it('should return the boolean as is', function ()
            Lust.expect(IsValid(true)).to.be.truthy()
            Lust.expect(IsValid(false)).to_not.be.truthy()
        end)

        Lust.it('should return true for all numbers except 0', function ()
            Lust.expect(IsValid(123)).to.be.truthy()
            Lust.expect(IsValid(-34)).to.be.truthy()
            Lust.expect(IsValid(3.52)).to.be.truthy()
            Lust.expect(IsValid(0)).to_not.be.truthy()
            Lust.expect(IsValid(0.0)).to_not.be.truthy()
        end)

        Lust.it('should return true for non-empty strings', function ()
            Lust.expect(IsValid("This is a valid string")).to.be.truthy()
            Lust.expect(IsValid('')).to_not.be.truthy()
        end)

        Lust.it('should return true for non-empty tables', function ()
            Lust.expect(IsValid({ key = 'Value' })).to.be.truthy()
            Lust.expect(IsValid({})).to_not.be.truthy()
        end)

        Lust.it('should return true for functions/threads/userdata', function ()
            Lust.expect(IsValid(function () end)).to.be.truthy()
            --  Todo: threads and userdata
        end)

    end)

    --  DISINTEGRATE
    --  ============

    Lust.describe('Disintegrate', function ()
        
        Lust.it('should split numbers into whole and fractional parts', function ()
            
            Lust.expect(Disintegrate(5)).to.equal(5)
            
            local whole, fractional = Disintegrate(3.14)
            Lust.expect(whole).to.equal(3)
            Lust.expect(fractional).to.equal(0.14)
            
            whole, fractional = Disintegrate(-3.14159265)
            Lust.expect(whole).to.equal(-3)
            Lust.expect(fractional).to.equal(-0.14159265)
        end)

        Lust.it('should split strings on whitespace by default', function ()
            Lust.expect(Disintegrate('Word')).to.equal('Word')

            local word1, word2 = Disintegrate('Hello World')
            Lust.expect(word1).to.equal('Hello')
            Lust.expect(word2).to.equal('World')
        end)

        Lust.it('should split string based on given separator', function ()
            local elements = table.pack(Disintegrate('Module::1::25:::43', '::'))
            Lust.expect(elements).to.equal({ 'Module', '1', '25', '43', n = 4 })
        end)

        Lust.it('should split a table into its constituents', function ()
            local element1, element2, element3 = Disintegrate({ 'Y', 'O', '!' })
            Lust.expect(element1).to.equal('Y')
            Lust.expect(element2).to.equal('O')
            Lust.expect(element3).to.equal('!')
            Lust.expect(Disintegrate({})).to_not.exist()
        end)

    end)

end)