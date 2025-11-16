const mysql = require('mysql2');

// 创建数据库连接
const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'your_mysql_password', // 替换为你的MySQL密码
  port: 3306,
  database: 'hiolabsDB'
});

// 连接数据库
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    return;
  }
  console.log('Database connection successful');
  
  // 查询数据库版本
  connection.query('SELECT version() AS version', (err, results) => {
    if (err) {
      console.error('Error querying database:', err);
      connection.end();
      return;
    }
    console.log('Database version:', results[0].version);
    
    // 关闭数据库连接
    connection.end();
  });
});