local db = require('db')
db.connect()

local transaction = {}

transaction.registerTransaction = function(o, data)
	-- salvar nova transação
	-- caso seja periodica, procurar plugin com scheduler
	-- https://stackoverflow.com/questions/20109094/how-do-i-execute-a-global-function-on-a-specific-day-at-a-specific-time-in-lua
	print('registerTransaction')
end

transaction.getTransactions = function(o, data)
	-- retorna todas as transações de um usuario
	print('getTransactions')
	db.getAllTransactions()
end

transaction.getTransactionById = function(o, data)
	-- retorna uma transação com base em sua id
	print('getTransactionById')
	db.getCompanyById(data['id'])
end

transaction.removePeriodicTransaction = function(o, data)
	-- remove a transação periodica com base no id
	print('registerPeriodicTransaction')
end

return transaction