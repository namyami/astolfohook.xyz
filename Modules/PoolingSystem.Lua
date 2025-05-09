--[[ Made by Swordphin ]]--

--[[
	
	API:
	
	Pool:Create(integer Size, instance Part)
		[arguments]
			integer Size
				--- Specify the amount of parts you want to duplicate and pool
			instance Part
				--- The template part that this script will be duplicating
		[returns]
			table
				--- The returned list of all objects
				
	
	Pool:GetObject(table List)
		[arguments]
			table List
				--- Use the list created from :Create() to fetch a part from their pool.
		[returns]
			instance Part
				--- Returns the given part. If the pool is exhausted (exceeds the size), nil will instead be returned
				
				
	Pool:Destroy(table List, instance Part)
		[arguments]
			table List
				--- Use the list created from :Create()
			instance Part
				--- The part that will be returned to the list that you specified.
				
	
	Pool:Clear(table List)
		[arguments]
			table List
				--- Use the list created from :Create(). Removes all instances of all pooled objects and resets the values of the table to nil.
					Only use if you no longer need the pool.
		[returns]
			table List
				--- returns empty table
	
	
--]]




local Pool = {}

local tablei = table.insert
local tabler = table.remove
local CFramenew = CFrame.new

local ReplicatedStorage = game.ReplicatedStorage

local PoolFolder = Instance.new("Folder")
PoolFolder.Name = "PoolingObjects"
PoolFolder.Parent = ReplicatedStorage

function Pool:Create(size, obj)
	local list = {}
	
	if script:FindFirstChild(obj.Name) == nil then
		local Folder = Instance.new("Folder")
		Folder.Name = obj.Name
		Folder.Parent = PoolFolder
	end
	
	obj.Parent = PoolFolder[obj.Name]
	for i = 1, size - 1 do
		local newObj = obj:Clone()
		newObj.Parent = PoolFolder[obj.Name]
		tablei(list, newObj)
	end
	
	return list
end

function Pool:GetObject(list)
	if #list > 0 then
		local obj = list[1]
		tabler(list, 1)
		return obj
	end
	
	return nil
end

function Pool:Destroy(list, obj)
	obj.Parent = PoolFolder[obj.Name]
	obj.CFrame = CFramenew(0,0,0)
	
	tablei(list, obj)
end

function Pool:Clear(list)
	local NameOfObj = ""
	PoolFolder[list[1].Name]:Destroy()
	for i = 1, #list do
		list[i] = nil
	end
	
	list = {}
	return list
end

return Pool
