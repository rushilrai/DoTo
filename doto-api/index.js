var express = require("express");
var sql = require("mssql");
var cors = require('cors');
var app = express();

app.use(express.json());
app.use(cors());

var server = app.listen(process.env.PORT || 8080, function () {
    var port = server.address().port;
    console.log("App now running on port", port);
});

var dbConfig = {
    server: "",
    database: "",
    user: "",
    password: "",
    options: {
        encrypt: true
    }
};

//Retrieve All Lists
app.get("/api/lists", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query("SELECT listID AS [Lists.ID], listName AS [Lists.Name], listDesc AS [Lists.Desc] FROM [dbo].[lists] FOR JSON PATH",
                function (err, jsonResponse) {
                    var key = Object.keys(jsonResponse.recordset[0]);
                    res.send(JSON.parse(jsonResponse.recordset[0][key]));
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Retrieve ListTasks By ID
app.get("/api/list/:id", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(`SELECT taskID AS [Tasks.ID], taskName AS [Tasks.Name], taskStatus AS [Tasks.Status] FROM [dbo].[list${req.params.id}] FOR JSON PATH`,
                function (err, jsonResponse) {
                    console.log(jsonResponse.rowsAffected[0]);
                    if (jsonResponse.rowsAffected[0] == [0]) {
                        res.send('empty', 210);
                    } else {
                        var key = Object.keys(jsonResponse.recordset[0]);
                        res.send(JSON.parse(jsonResponse.recordset[0][key]), 200);
                    }
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Add New List
app.get("/api/addList/:name/:desc", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `INSERT INTO [dbo].[lists] (listName, listDesc) VALUES ('${req.params.name}', '${req.params.desc}'); 
     DECLARE @tablename nvarchar(20);
     DECLARE @DynamicSQL nvarchar(1000);
     SET @tablename = (SELECT TOP(1) listID FROM [dbo].[lists] ORDER BY listID DESC);
     SET @DynamicSQL = N'CREATE TABLE ' + 'list' + @tablename + ' (taskID INT PRIMARY KEY IDENTITY (1 , 1), taskName VARCHAR(100), taskStatus BIT)';
     exec sp_executesql @DynamicSQL;`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Added');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Add New Task
app.get("/api/addTask/:listID/:taskName", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `INSERT INTO [dbo].[list${req.params.listID}] (taskName, taskStatus) VALUES ('${req.params.taskName}', '0');`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Task Added');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Set Task To Complete
app.get("/api/taskComplete/:listID/:taskID", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `UPDATE [dbo].[list${req.params.listID}]
                    SET taskStatus = '1'
                    WHERE taskID = ${req.params.taskID};`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Set Task to Complete');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Set Task To Incomplete
app.get("/api/taskInComplete/:listID/:taskID", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `UPDATE [dbo].[list${req.params.listID}]
                    SET taskStatus = '0'
                    WHERE taskID = ${req.params.taskID};`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Set Task to Incomplete');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Delete Task
app.get("/api/deleteTask/:listID/:taskID", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `DELETE FROM [dbo].[list${req.params.listID}] WHERE taskID='${req.params.taskID}';`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Deleted Task');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});

//Delete List
app.get("/api/deleteList/:listID", async function (req, res) {
    var conn = await new sql.ConnectionPool(dbConfig);
    var sqlQuery = `DELETE FROM [dbo].[lists] WHERE listID='${req.params.listID}';
                    DROP TABLE [dbo].[list${req.params.listID}];`;
    console.log(sqlQuery);

    conn.connect()
        .then(async function () {
            var request = await new sql.Request(conn);
            await request.query(sqlQuery,
                function (err, response) {
                    res.send('Deleted List');
                });
        })
        .catch(function (err) {
            console.log(err);
            conn.close();
        });
});