local pegasus = require('pegasus')
local company = require('company')
local transaction = require('transaction')

local server = pegasus:new({
  port='9090'
})

server:start(function (req, res)
	if req:method() == 'GET' then
		if req:path() == '/recarga/getCompanies' then company:getCompanies()
		elseif req:path() == '/recarga/getTransactions' then transaction:getTransactions()
		elseif req:path() == '/recarga/getTransaction' then transaction:getTransactionById(req.querystring)
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end

	elseif req:method() == 'POST' then
		if req:path() == '/recarga/' then transaction:registerTransaction(req:post())
		elseif req:path() == '/recarga/registerCompany' then company:registerCompany(req:post())
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end

	elseif req:method() == 'DELETE' then
		if req:path() == '/recarga/delete/company' then company:removeCompany(req.querystring)
		elseif req:path() == '/recarga/delete/periodic' then transaction:removePeriodicTransaction(req.querystring)
		else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
		end

	else res:addHeader('Content-Type', 'text/html'):statusCode(501, '501 Not implemented!'):write('501 Not implemented!')
	end
end)