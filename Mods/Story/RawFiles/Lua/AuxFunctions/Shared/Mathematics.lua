-- ==================
-- CALCULATE DISTANCE
-- ==================

---Calculates distance between two objects
---@param sourcePos number[]
---@param targetPos number[]
---@return number
function CalculateDistance(sourcePos, targetPos)
    if not sourcePos or not targetPos then return 0 end
    local x2, y2, z2 = table.unpack(sourcePos)
    local x1, y1, z1 = table.unpack(targetPos)
    return math.floor(math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2))
end

--  ===========
--  DETERMINANT
--  ===========

---Calculate determinant for a 2X2 matrix. TODO: Generalize (using Crammer's rule?)
---@param x table 2X2 Matrix
---@return number determinant
function Calculate2X2Determinant(x)
    if type(x) ~= 'table' then return end
    local a, b = x[1][1], x[1][2]
    local c, d = x[2][1], x[2][2]
    return a * d - b * c
end

--  ==================
--  VECTOR MATHEMATICS
--  ==================

---@class Vector
---@field Pos number[] x, y, z
---@field dCos number[] Direction Cosines (in radians)
Vector = {
    Pos = {0, 0, 0},
    dCos = {0, 0, 0}
}

---Create new Vector
---@param object any
---@return table
function Vector:New(object)
    local object = object or {}
    object = Integrate(self, object)
    return object
end

---Get the magnitude of the Vector
---@return number Magnitude Vector Magnitude
function Vector:Magnitude()
    local x, y, z = table.unpack(self.Pos)
    return math.sqrt((x^2) + (y^2) + (z^2))
end

---Determine directional cosines of the Vector
---@return number[] directionCosines in radians
function Vector:DetermineDirectionalCosines()
    local x, y, z = table.unpack(self.Pos)
    local mag = self:Magnitude()
    self.dCos = { x/mag, y/mag, z/mag }
    return self.dCos
end

---Add two vectors
---@param self Vector
---@param v Vector
---@return Vector res
function Vector:Add(v)
    local x1, y1, z1 = table.unpack(self.Pos)
    local x2, y2, z2 = table.unpack(v.Pos)
    local res = self:New({ Pos = {x1 + x2, y1 + y2, z1 + z2} })
    res:DetermineDirectionalCosines()
    return res
end

---Get the difference of two vectors
---@param self Vector
---@param v Vector
---@return Vector
function Vector:Diff(v)
    local x1, y1, z1 = table.unpack(self.Pos)
    local x2, y2, z2 = table.unpack(v.Pos)
    local res = self:New({ Pos = {x1 - x2, y1 - y2, z1 - z2} })
    res:DetermineDirectionalCosines()
    return res
end

---Dot product of two vectors
---@param self Vector
---@param v Vector
---@return number ScalarProduct
function Vector:DotProduct(v)
    local x1, y1, z1 = table.unpack(self.Pos)
    local x2, y2, z2 = table.unpack(v.Pos)
    return x1 * x2 + y1 * y2 + z1 * z2
end

---Cross product of two vectors
---@param self Vector
---@param v Vector
---@return Vector CrossProduct
function Vector:CrossProduct(v)
    local x1, y1, z1 = table.unpack(self.Pos)
    local x2, y2, z2 = table.unpack(v.Pos)
    local det = Calculate2X2Determinant
    local res = self:New({ Pos = { det({{y1, z1}, {y2, z2}}) + det({{x1, z1}, {x2, z2}}) + det({{x1, y1}, {x2, y2}}) } })
    res:DetermineDirectionalCosines()
    return res
end