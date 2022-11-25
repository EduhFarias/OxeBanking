local db = require('db')
db.connect()

local user = {}

user.getUserById = function(o, data)
	-- retorna o objeto usuario caso exista
	-- necessario comunicacao com o servico de conta
	print('getUserById')
	db.getAllUsers()
end

user.hasBalance = function(o, data)
	-- checar se o usuario possui saldo suficiente para recarga
	-- necessario comunicacao com o servico de conta
	print('hasBalance')
end

return user