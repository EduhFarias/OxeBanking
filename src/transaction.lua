local json = require('JSON')

local db = require('db')
local user = require('user')

db.connect()

local transaction = {}

local printTable = function(table)
    for k, v in pairs(table) do
        print(k, '=', v)
    end
end

transaction.registerTransaction = function(o, data, res)
	local hasBalance = user.hasBalance(data['user'], data['value'])
	if hasBalance then
		data['periodic'] = data['periodic'] and 1 or 0
		local success = db.registerTransaction(data)
		if success then
			res:addHeader('Content-Type', 'text/html'):statusCode(201, '201 Created!'):write('Recarga efetuada com sucesso!')
		else res:addHeader('Content-Type', 'text/html'):statusCode(500, '500 Internal Error!'):write('Recarga não pôde ser realizada!')
		end
	else res:addHeader('Content-Type', 'text/html'):statusCode(500, '500 Internal Error!'):write('Recarga não pôde ser realizada!')
	end
	-- caso seja periodica, procurar plugin com scheduler
	-- https://stackoverflow.com/questions/20109094/how-do-i-execute-a-global-function-on-a-specific-day-at-a-specific-time-in-lua
end

transaction.getTransactions = function(o, res)
	local transactions = db.getAllTransactions()
	-- for idx, transaction in pairs(transactions) do
	-- 	for k, v in pairs(transaction) do
	-- 		print(k, '=', v)
	-- 	end
	-- end
	res:addHeader('Content-Type', 'application/json'):statusCode(200, "200 OK"):write(json:encode(transactions))
end

transaction.getTransactionById = function(o, id, res)
	res:addHeader('Content-Type', 'application/json'):statusCode(200, '200 OK!'):write(json:encode(db.getTransactionById(id['id'])))
end

transaction.getTransactionsByUser = function(o, uid, res)
	local transactions = db.getTransactionsByUser(uid['uid'])
	-- for idx, transaction in pairs(transactions) do
	-- 	for k, v in pairs(transaction) do
	-- 		print(k, '=', v)
	-- 	end
	-- end
	res:addHeader('Content-Type', 'application/json'):statusCode(200, "200 OK"):write(json:encode(transactions))
end

transaction.removePeriodicTransaction = function(o, id, res)
	local success = db.removePeriodic(id['id'])
	if success then res:addHeader('Content-Type', 'text/html'):statusCode(200, '200 Successful!'):write('Recarga alterada!')
	else res:addHeader('Content-Type', 'text/html'):statusCode(500, '500 Internal Error!'):write('Não foi possível realizar a alteração!')
	end
end

return transaction
