const Base = require('./base.js');
const moment = require('moment');
const bcrypt = require('bcryptjs');

// 密码强度检查函数
function isStrongPassword(password) {
    // 至少8个字符，包含字母、数字和特殊字符
    const regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return regex.test(password);
}
module.exports = class extends Base {
    /**
     * index action
     * @return {Promise} []
     */
    async indexAction() {
        const data = await this.model('admin').where({
            // is_show: 1,
            is_delete: 0
        }).select();
        for (const item of data) {
            if (item.last_login_time != 0) {
                item.last_login_time = moment.unix(item.last_login_time).format('YYYY-MM-DD HH:mm:ss');
            } else {
                item.last_login_time = '还没登录过'
            }
            item.password = '';
        }
        return this.success(data);
    }
    async adminDetailAction() {
        let id = this.post('id')
        let info = await this.model('admin').where({
            id: id
        }).find();
        return this.success(info);
    }
    async adminAddAction() {
        let user = this.post('user');
        let password = user.password;
        let salt = bcrypt.genSaltSync(10); // 生成盐值
        let upData = {
            username: user.username,
            password_salt: salt
        };
        if (password.trim().length != 0) {
            // 密码强度检查
            if (!isStrongPassword(password)) {
                return this.fail(400, '密码强度不足，至少8个字符，包含字母、数字和特殊字符');
            }
            let hashedPassword = bcrypt.hashSync(password, salt);
            upData.password = hashedPassword;
            // 记录加密日志
            think.logger.info(`用户 ${user.username} 密码加密成功，盐值: ${salt}`);
        }
        await this.model('admin').add(upData);
        return this.success();
    }
    async adminSaveAction() {
        let user = this.post('user');
        let change = this.post('change');
        let upData = {
            username: user.username,
        };
        if (change == true) {
            let newPassword = user.newpassword;
            if (newPassword.trim().length != 0) {
                // 密码强度检查
                if (!isStrongPassword(newPassword)) {
                    return this.fail(400, '密码强度不足，至少8个字符，包含字母、数字和特殊字符');
                }
                let salt = bcrypt.genSaltSync(10);
                let hashedPassword = bcrypt.hashSync(newPassword, salt);
                upData.password = hashedPassword;
                upData.password_salt = salt;
                // 记录加密日志
                think.logger.info(`用户 ${user.username} 密码更新加密成功，盐值: ${salt}`);
            }
        }
        let ex = await this.model('admin').where({
            username: user.username,
            id: ['<>', user.id]
        }).find();
        if (!think.isEmpty(ex)) {
            return this.fail(400, '重名了')
        }
        // if (user.id == 14) {
        //     return this.fail(400, '演示版后台的管理员密码不能修改!本地开发，删除这个判断')
        // }
        await this.model('admin').where({
            id: user.id
        }).update(upData);
        return this.success();
    }
    async infoAction() {
        const id = this.get('id');
        const model = this.model('user');
        const data = await model.where({
            id: id
        }).find();
        return this.success(data);
    }
    async storeAction() {
        if (!this.isPost) {
            return false;
        }
        const values = this.post();
        const id = this.post('id');
        const model = this.model('user');
        values.is_show = values.is_show ? 1 : 0;
        values.is_new = values.is_new ? 1 : 0;
        if (id > 0) {
            await model.where({
                id: id
            }).update(values);
        } else {
            delete values.id;
            await model.add(values);
        }
        return this.success(values);
    }
    async deleAdminAction() {
        const id = this.post('id');
        await this.model('admin').where({
            id: id
        }).limit(1).delete();
        return this.success();
    }
    async showsetAction() {
        const model = this.model('show_settings');
        let data = await model.find();
        return this.success(data);
    }
    async showsetStoreAction() {
        let id = 1;
        const values = this.post();
        const model = this.model('show_settings');
        await model.where({
            id: id
        }).update(values);
        return this.success(values);
    }
    async changeAutoStatusAction() {
        const status = this.post('status');
        await this.model('settings').where({
            id: 1
        }).update({
            autoDelivery: status
        });
        return this.success();
    }
    async storeShipperSettingsAction() {
        const values = this.post();
        await this.model('settings').where({
            id: values.id
        }).update(values);
        return this.success();
    }
    async senderInfoAction() {
        let info = await this.model('settings').where({
            id: 1
        }).find();
        return this.success(info);
    }
};