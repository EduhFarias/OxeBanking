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
        CREATE TABLE transaction (
            id INTEGER PRIMARY KEY,
            value REAL NOT NULL,
            payment TEXT,
            company_id INTEGER NOT NULL,
            user_id INTEGER NOT NULL,
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

    DBI.Do(dbd, 'INSERT INTO company VALUES (0, "Eduardo", 20.0, "012.345.678-90")')
    DBI.Do(dbd, 'INSERT INTO company VALUES (0, "Teste", 30.0, "012.345.678-91")')
end

-- User
db.getUserById = function(uid)
    print(uid)
    sel = dbd:prepare( "select * from company user id = $1;" )
    sel:execute(uid)
    local user = sel:fetch(true)
    print(user)
    printTable(user)
    
end

db.getAllUsers = function()
    print('all users')
    stmt = dbd:prepare( "select * from company;" )
    stmt:execute()
    local teste = stmt:fetch(true)
    printTable(teste)
end

-- Company
db.getAllCompanies = function()
    print('all companies')
    stmt = dbd:prepare( "select * from company;" )
    stmt:execute()
    local teste = stmt:fetch(true)
    printTable(teste)
end

db.getCompanyById = function(id)
    print(id)
    sel = dbd:prepare( "select * from company where id = $1;" )
    sel:execute(id)
    local company = sel:fetch(true)
    print(company)
    printTable(company)
end

db.removeCompany = function(id)
    del = dbd:prepare("delete from company where id = $1")
    del:execute(id)
end

-- Transaction
db.getAllTransactions = function()
    print('all transactions')
    stmt = dbd:prepare( "select * from transaction;" )
    stmt:execute()
    local teste = stmt:fetch(true)
    printTable(teste)
end

db.getTransactionsByUser = function(uid)
    print(uid)
    sel = dbd:prepare("select * from transaction where user_id = $1")
    sel:execute(uid)
    local teste = stmt:fetch(true)
    printTable(teste)
end

db.getTransactionById = function(id)
    print(id)
    sel = dbd:prepare("select * from transaction where id = $1")
    sel:execute(uid)
    local teste = stmt:fetch(true)
    printTable(teste)
end

return db

-- for row in statement:rows(true) do
--     print(row['id'])
--     print(row['name'])
--     print(row['cnpj'])
-- end
