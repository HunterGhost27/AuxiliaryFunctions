--  =========
--  LOAD FILE
--  =========

--- Load file contents
---@param fileName string FilePath
---@param context string PathContext. 'data' for modData. 'user' or nil for osirisData
---@return table file Parsed file contents
---@return string fileContents Stringified file contents
function LoadFile(fileName, context)
    local file
    local _, fileContents = pcall(Ext.LoadFile, fileName, context)
    if string.match(fileName, '.json') then
        if ValidString(fileContents) then file = Ext.JsonParse(fileContents); Destringify(file)
        else file = {} end
    else file = fileContents end
    return file, fileContents
end

--  =========
--  SAVE FILE
--  =========

--- Save file
---@param fileName string FilePath
---@param contents any File Contents to save
function SaveFile(fileName, contents)
    if ValidString(fileName) then
        local fileContents = type(contents) == 'table' and Ext.JsonStringify(Rematerialize(contents)) or tostring(contents) or ""
        Ext.SaveFile(fileName, fileContents)
    end
end

--  ===================
--  LOAD MULTIPLE FILES
--  ===================

---Loads multiple files
---@param fileNames table Array of fileNames
---@param context string Path-Context
---@return table files Table of files
function LoadFiles(fileNames, context)
    local files
    if type(fileNames) ~= 'table' then return end
    for _, fileName in ipairs(fileNames) do
        local _, fileContents = pcall(Ext.LoadFile, fileName, context)
        if string.match(fileName, '.json') then
            if ValidString(fileContents) then files[fileName] = Ext.JsonParse(fileContents); Destringify(files[fileName])
            else files[fileName] = {} end
        else files[fileName] = fileContents end
    end
    return files
end

--  ===========
--  FILE OBJECT
--  ===========

---@class File @File Object
---@field Name string FileName
---@field PathContext string|nil FilePath Context. Typically `nil`
---@field Contents string|table FileContents
---@field StrContents string Stringified FileContents
File = {}

---Instantiate new File-Object
---@param object table
---@return File
function File:New(object)
    local object = object or {}
    object = Integrate(self, object)
    return object
end

---Updates Info
---@param fileName string
---@param context string
function File:SetPath(fileName, context)
    self.Name = fileName
    self.PathContext = context
end

---File-Load Method
---@param fileName string|nil Overrides self.Name
---@param context string|nil Overrides self.PathContext
function File:Load(fileName, context)
    local fileName = fileName or self.Name
    local pathContext = context or self.PathContext
    self.Contents, self.StrContents = LoadFile(fileName, pathContext)
end

---Overrides FileContents with data
---@param data any
function File:Override(data)
    self.Contents = data
    self.StrContents = type(data) == 'table' and Ext.JsonStringify(Rematerialize(data)) or tostring(data) or ""
end

---Saves File
---@param fileName string|nil
---@param contents string|nil
function File:Save(fileName, contents)
    local fileName = fileName or self.Name
    local contents = contents or self.Contents
    SaveFile(fileName, contents)
end