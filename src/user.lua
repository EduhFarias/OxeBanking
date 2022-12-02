local db = require('db')
db.connect()

local user = {}

user.getUserById = function(uid)
	return db.getUserById(uid)
end

user.getUsers = function()
	for idx, user in pairs(db.getAllUsers()) do
		for k, v in pairs(user) do
			print(k, '=', v)
		end
	end
end

user.hasBalance = function(uid, value)
	local user = user.getUserById(uid)
	if user.balance - value >= 0.0 then return true end
	return false
end

return user