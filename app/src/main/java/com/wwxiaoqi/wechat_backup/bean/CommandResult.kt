package com.wwxiaoqi.wechat_backup.bean

/**
 * 返回的命令结果
 */
class CommandResult(
  /**
   * 结果码
   */
  var result: Int,
  /**
   * 成功信息
   */
  var successMsg: String?,
  /**
   * 错误信息
   */
  var errorMsg: String?
)