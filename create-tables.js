const think = require('thinkjs');
const path = require('path');

// 创建ThinkJS应用
const app = new think.App({
  ROOT_PATH: __dirname,
  APP_PATH: path.join(__dirname, 'src'),
  proxy: true,
  env: 'development'
});

// 初始化应用
app.on('appReady', async () => {
  try {
    // 获取数据库连接
    const db = think.model('base').db;
    
    // 读取SQL文件内容
    const fs = require('fs');
    const sql = fs.readFileSync('./recommend.sql', 'utf8');
    
    // 执行SQL语句
    await db.execute(sql);
    
    console.log('数据表创建成功');
    process.exit(0);
  } catch (err) {
    console.error('创建数据表失败:', err);
    process.exit(1);
  }
});

app.run();