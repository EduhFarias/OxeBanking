local DBI = require('DBI')

local printTable = function(table)
    for k, v in pairs(table) do
        print(k, '=', v)
    end
end

local db = {}
local dbd

db.connect = function()
    -- Connect to db / created if not found
    dbd, err = DBI.Connect('SQLite3', 'database.sqlite3')
    assert( dbd, err )
    dbd:autocommit(true)
end

db.createTables = function()
    -- Create table for companies
    DBI.Do(dbd, [[ 
        CREATE TABLE company (
            id INTEGER PRIMARY KEY,
            name TEXT,
            cnpj TEXT UNIQUE
        )
        ]]
    )
    
    -- Create table for users
    DBI.Do(dbd, [[ 
        CREATE TABLE user (
            id INTEGER PRIMARY KEY,
            name TEXT,
            balance REAL NOT NULL,
            cpf TEXT UNIQUE
        )
        ]]
    )
    
    -- Create table for transactions
    DBI.Do(dbd, [[ 
        CREATE TABLE transfer (
            id INTEGER PRIMARY KEY,
            value REAL NOT NULL,
            payment TEXT,
            company INTEGER NOT NULL,
            user INTEGER NOT NULL,
            periodic INTEGER NOT NULL
        )
        ]]
    )
    
    -- Initialize db with default companies
    DBI.Do(dbd, 'INSERT INTO company VALUES (0, "Vivo", "02.558.157/0001-62")')
    DBI.Do(dbd, 'INSERT INTO company VALUES (1, "Tim", "02.600.854/0001-34")')
    DBI.Do(dbd, 'INSERT INTO company VALUES (2, "Oi", "76.535.764/0002-24")')
    DBI.Do(dbd, 'INSERT INTO company VALUES (3, "Claro", "40.432.544/0001-47")')
    DBI.Do(dbd, 'INSERT INTO company VALUES (4, "Telecom", "07.148.170/0001-67")')

    DBI.Do(dbd, 'INSERT INTO user VALUES (0, "Eduardo", 20.0, "012.345.678-90")')
    DBI.Do(dbd, 'INSERT INTO user VALUES (1, "Teste", 30.0, "012.345.678-91")')
    DBI.Do(dbd, 'INSERT INTO user VALUES (2, "Teste2", 5000.0, "012.345.678-92")')

    DBI.Do(dbd, 'INSERT INTO transfer VALUES (0, 10.0, "Saldo", 0, 0, 0)')
    DBI.Do(dbd, 'INSERT INTO transfer VALUES (1, 15.0, "Cartão", 1, 1, 1)')
    DBI.Do(dbd, 'INSERT INTO transfer VALUES (2, 30.0, "Saldo", 2, 2, 0)')
end

-- User
db.getUserById = function(uid)
    sel = dbd:prepare( "select * from user where id = $1;" )
    sel:execute(uid)
    local user = sel:fetch(true)
    return user
    
end

db.getAllUsers = function()
    users = {}
    stmt = dbd:prepare( "select * from user;" )
    stmt:execute()
    for row in stmt:rows(true) do
        table.insert(users, row)
    end
    return users
end

-- Company
db.registerCompany = function(company)
    insert = dbd:prepare( "INSERT INTO company(name, cnpj) VALUES ($1, $2);" )
    success, err = insert:execute(company['name'], company['cnpj'])
    return success
end

db.getAllCompanies = function()
    companies = {}
    stmt = dbd:prepare( "select * from company;" )
    stmt:execute()
    for row in stmt:rows(true) do
        table.insert(companies, row)
    end
    return companies
end

db.getCompanyById = function(id)
    sel = dbd:prepare( "select * from company where id = $1;" )
    sel:execute(id)
    local company = sel:fetch(true)
    return company
end

db.removeCompany = function(id)
    del = dbd:prepare("delete from company where id = $1")
    success, err = del:execute(id)
    return success
end

-- Transaction
db.getAllTransactions = function()
    transactions = {}
    stmt = dbd:prepare( "select * from transfer;" )
    stmt:execute()
    for row in stmt:rows(true) do
        table.insert(transactions, row)
    end
    return transactions
end

db.getTransactionsByUser = function(uid)
    transactions = {}
    sel = dbd:prepare("select * from transfer where user = $1")
    sel:execute(uid)
    for row in sel:rows(true) do
        table.insert(transactions, row)
    end
    return transactions
end

db.getTransactionById = function(id)
    sel = dbd:prepare("select * from transfer where id = $1")
    sel:execute(id)
    local transaction = stmt:fetch(true)
    return transaction
end

db.registerTransaction = function(transaction)
    insert = dbd:prepare( "INSERT INTO transfer(value, payment, company, user, periodic) VALUES ($1, $2, $3, $4, $5);" )
    success, err = insert:execute(transaction['value'], transaction['payment'], transaction['company'], transaction['user'], transaction['periodic'])
    return success
end

db.removePeriodic = function(transaction)
    update = dbd:prepare( "UPDATE transfer SET periodic = 0 WHERE id = $1;" )
    success, err = update:execute(transaction)
    return success
end

return db
