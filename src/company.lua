local db = require('db')
db.connect()

local company = {}

company.registerCompany = function(o, data)
	-- salvar no banco as informações da operadora
	print('registerCompany')
end

company.getCompanies = function(o)
	-- retorna todas as operadoras cadastradas
	print('getCompanies')
	db.getAllCompanies()
end

company.getCompanyById = function(o, data)
	print(data)
	db.connect()
	db.getCompanyById(data)
end

company.removeCompany = function(o, data)
	-- remove a operadora cadastrada
	print('removeCompany')
	db.removeCompany(data['id'])
end

return company