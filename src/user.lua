local user = {}

user.getUserById = function(data)
	-- retorna o objeto usuario caso exista
	-- necessario comunicacao com o servico de conta
	print('getUserById')
end


user.hasBalance = function(data)
	-- checar se o usuario possui saldo suficiente para recarga
	-- necessario comunicacao com o servico de conta
	print('hasBalance')
end

return user