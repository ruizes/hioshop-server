const mysql = require('mysql2');
const config = require('./src/common/config/database.js');

// 创建数据库连接
const connection = mysql.createConnection({
  host: config.host,
  user: config.user,
  password: '123123',
  database: config.database
});

// 连接数据库
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    return;
  }
  console.log('Database connection successful');
  
  // 关闭数据库连接
  connection.end();
});