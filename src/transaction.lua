local transaction = {}

transaction.registerTransaction = function(data)
	-- salvar nova transação
	-- caso seja periodica, procurar plugin com scheduler
	-- https://stackoverflow.com/questions/20109094/how-do-i-execute-a-global-function-on-a-specific-day-at-a-specific-time-in-lua
	print('registerTransaction')
end

transaction.getTransactions = function(data)
	-- retorna todas as transações de um usuario
	print('getTransactions')
end

transaction.getTransactionById = function(data)
	-- retorna uma transação com base em sua id
	print('getTransactionById')
end

transaction.removePeriodicTransaction = function(data)
	-- remove a transação periodica com base no id
	print('registerPeriodicTransaction')
end

return transaction