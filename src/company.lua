local company = {}

company.registerCompany = function(data)
	-- salvar no banco as informações da operadora
	print('registerCompany')
end

company.getCompanies = function()
	-- retorna todas as operadoras cadastradas
	print('getCompanies')
end

company.removeCompany = function(data)
	-- remove a operadora cadastrada
	print('removeCompany')
end

return company