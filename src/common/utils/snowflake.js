// 雪花算法实现
class Snowflake {
  constructor(workerId = 1, datacenterId = 1) {
    // 起始时间戳 (2024-01-01)
    this.epoch = 1704067200000;
    // 机器ID位数
    this.workerIdBits = 5;
    // 数据中心ID位数
    this.datacenterIdBits = 5;
    // 序列号位数
    this.sequenceBits = 12;

    // 最大机器ID
    this.maxWorkerId = -1 ^ (-1 << this.workerIdBits);
    // 最大数据中心ID
    this.maxDatacenterId = -1 ^ (-1 << this.datacenterIdBits);
    // 序列号掩码
    this.sequenceMask = -1 ^ (-1 << this.sequenceBits);

    // 机器ID左移位数
    this.workerIdShift = this.sequenceBits;
    // 数据中心ID左移位数
    this.datacenterIdShift = this.sequenceBits + this.workerIdBits;
    // 时间戳左移位数
    this.timestampLeftShift = this.sequenceBits + this.workerIdBits + this.datacenterIdBits;

    // 机器ID
    this.workerId = workerId;
    // 数据中心ID
    this.datacenterId = datacenterId;
    // 序列号
    this.sequence = 0;
    // 上一次时间戳
    this.lastTimestamp = -1;

    // 验证机器ID和数据中心ID
    if (this.workerId > this.maxWorkerId || this.workerId < 0) {
      throw new Error(`Worker ID can't be greater than ${this.maxWorkerId} or less than 0`);
    }
    if (this.datacenterId > this.maxDatacenterId || this.datacenterId < 0) {
      throw new Error(`Datacenter ID can't be greater than ${this.maxDatacenterId} or less than 0`);
    }
  }

  // 生成唯一ID
  nextId() {
    let timestamp = this.timeGen();

    // 如果当前时间小于上一次时间戳，说明系统时钟回退过
    if (timestamp < this.lastTimestamp) {
      throw new Error(`Clock moved backwards. Refusing to generate id for ${this.lastTimestamp - timestamp} milliseconds`);
    }

    // 如果是同一时间生成的，则进行序列号自增
    if (this.lastTimestamp === timestamp) {
      this.sequence = (this.sequence + 1) & this.sequenceMask;
      // 序列号溢出
      if (this.sequence === 0) {
        // 阻塞到下一个毫秒，获取新的时间戳
        timestamp = this.tilNextMillis(this.lastTimestamp);
      }
    } else {
      // 时间戳改变，序列号重置
      this.sequence = 0;
    }

    // 保存当前时间戳
    this.lastTimestamp = timestamp;

    // 组合生成ID
    return ((timestamp - this.epoch) << this.timestampLeftShift) |
      (this.datacenterId << this.datacenterIdShift) |
      (this.workerId << this.workerIdShift) |
      this.sequence;
  }

  // 生成时间戳
  timeGen() {
    return Date.now();
  }

  // 阻塞到下一个毫秒
  tilNextMillis(lastTimestamp) {
    let timestamp = this.timeGen();
    while (timestamp <= lastTimestamp) {
      timestamp = this.timeGen();
    }
    return timestamp;
  }
}

// 导出单例
module.exports = new Snowflake();