local pegasus = require('pegasus')
local json = require('JSON')
local company = require('company')
local transaction = require('transaction')

local server = pegasus:new({
  port='9090'
})

server:start(function (req, res)
	local headers = req:headers()

	if req:method() == 'GET' then
		if req:path() == '/recarga/getCompanies' then company:getCompanies(res)
		elseif req:path() == '/recarga/getTransactions' then transaction:getTransactions(res)
		elseif req:path() == '/recarga/getTransaction' then transaction:getTransactionById(req.querystring, res)
		elseif req:path() == '/recarga/getUserTransactions' then transaction:getTransactionsByUser(req.querystring, res)
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end
		
	elseif req:method() == 'POST' then
		local data = json:decode(req:receiveBody())
		if req:path() == '/recarga/' then transaction:registerTransaction(data, res)
		elseif req:path() == '/recarga/registerCompany' then company:registerCompany(data, res)
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end

	elseif req:method() == 'DELETE' then
		if req:path() == '/recarga/delete/company' then company:removeCompany(req.querystring, res)
		elseif req:path() == '/recarga/delete/periodic' then transaction:removePeriodicTransaction(req.querystring, res)
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end

	else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
	end
end)
