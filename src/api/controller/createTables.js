// 在src/api/controller目录下创建一个临时控制器
const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    try {
      // 读取SQL文件内容
      const fs = require('fs');
      const sql = fs.readFileSync('./recommend.sql', 'utf8');
      
      // 执行SQL语句
      await this.model('base').db.execute(sql);
      
      return this.success('数据表创建成功');
    } catch (err) {
      return this.fail('创建数据表失败:', err);
    }
  }
};
