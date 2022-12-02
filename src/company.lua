local json = require('JSON')

local db = require('db')
db.connect()

local company = {}

company.registerCompany = function(o, data, res)
	local success = db.registerCompany(data)
	if success then
		res:addHeader('Content-Type', 'text/html'):statusCode(201, '201 Created!'):write('Operadora cadastrada!')
	else res:addHeader('Content-Type', 'text/html'):statusCode(500, '500 Internal Error!'):write('Não pôde cadastrar a operadora!')
	end
end

company.getCompanies = function(o, res)
	local companies = db.getAllCompanies()
	-- for idx, company in pairs(companies) do
	-- 	for k, v in pairs(company) do
	-- 		print(k, '=', v)
	-- 	end
	-- end
	res:addHeader('Content-Type', 'application/json'):statusCode(200, "200 OK"):write(json:encode(companies))
end

company.getCompanyById = function(o, id, res)
	res:addHeader('Content-Type', 'application/json'):statusCode(200, '200 OK!'):write(json:encode(db.getCompanyById(id['id'])))
end

company.removeCompany = function(o, id, res)
	local success = db.removeCompany(id['id'])
	if success then res:addHeader('Content-Type', 'text/html'):statusCode(200, '200 Successful!'):write('Operadora removida!')
	else res:addHeader('Content-Type', 'text/html'):statusCode(500, '500 Internal Error!'):write('Não foi possível realizar a alteração!')
	end
end

return company