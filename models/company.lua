local printTable = function(table)
	for k, v in pairs(table) do
		print(k, '=', v)
	end
end

-- Meta class
Company = { values = {}, name = '', cnpj = ''}

function Company:new (o, values, name, cnpj)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.values = values
	self.name = name
	self.cnpj = cnpj
	return o
end

function Company:print ()
	print("Company ")
	print("Name: R$ ", self.name)
	print("Values: ")
	for k, v in pairs(table) do
		print(k, '=', v)
	end
	print("CNPJ: ", self.cnpj)
end

return Company