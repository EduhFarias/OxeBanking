-- Meta class
Transaction = { value = 0, user = '', company = '', payment_method = '', periodic = false }

function Transaction:new (o, value, user, company, payment_method, periodic)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.value = value
	self.user = user
	self.company = company
	self.payment_method = payment_method
	self.periodic = periodic;
	return o
end

function Transaction:print ()
	print("Transaction \n")
	print("Value: R$ ", self.value)
	print("Value: R$ ", self.value)
	print("Value: R$ ", self.value)
	print("Value: R$ ", self.value)
end

return Transaction