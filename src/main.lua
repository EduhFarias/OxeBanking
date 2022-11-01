local pegasus = require 'pegasus'

local server = pegasus:new({
  port='9090'
})

local printTable = function(table)
  for k, v in pairs(table) do
	print(k, '=', v)
  end
end

local registerCompany = function(company)
	-- salvar no banco as informações da operadora
end

local registerTransaction = function(transaction)
	-- salvar nova transação
	-- caso seja periodica, procurar plugin com scheduler
	-- https://stackoverflow.com/questions/20109094/how-do-i-execute-a-global-function-on-a-specific-day-at-a-specific-time-in-lua
end

local getTransactions = function(userId)
	-- retorna todas as transações de um usuario
end

local getTransactionById = function(transactionId)
	-- retorna uma transação com base em sua id
end

local getUserById = function(userId)
	-- retorna o objeto usuario caso exista
end

local remove = function(transactionId)
	-- remove a transação periodica com base no id
end

local hasBalance = function(user)
	-- checar se o usuario possui saldo suficiente para recarga
end

local getCompanies = function()
	-- retorna todas as operadoras cadastradas
end

server:start(function (req, res)
	if req:method() == 'GET' then
		if req:path() == '/recarga/companies' then print('Todas as operadoras')
		elseif req:path() == '/recarga/transactions' then print('Todas as transações')
		elseif req:path() == '/recarga/transaction' then print('Pega transação pelo id')
		else print('Não implementado')
		end

	elseif req:method() == 'POST' then
		if req:path() == '/recarga/company' then print('Registra operadora')
		elseif req:path() == '/recarga/single' then print('Registra recarga unica')
		elseif req:path() == '/recarga/periodic' then print('Registra recarga e torna periodica')
		else print('Não implementado')
		end

	elseif req:method() == 'DELETE' then
		if req:path() == '/recarga/delete/company' then print('Remove operadora')
		elseif req:path() == '/recarga/delete/periodic' then print('Remove recarga periodica')
		else print('Não implementado')
		end

	else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!')
	end

  -- pegar o id do usuario que deseja fazer a recarga
  -- pegar id da empresa que fara a recarga
  -- valor
  -- se sera recarga periodica -> se sim usar um scheduler para definir o tempo
  -- metodo de pagamento

  -- caso post pega os dados com req:post()
  -- para alterar status, primeiro alteramos o valor apos header
end)