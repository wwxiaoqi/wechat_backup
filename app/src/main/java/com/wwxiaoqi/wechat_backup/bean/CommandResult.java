package com.wwxiaoqi.wechat_backup.bean;

/**
 * 返回的命令结果
 */
public class CommandResult {

  /**
   * 结果码
   **/
  public int result;

  /**
   * 错误信息
   **/
  public String errorMsg;

  /**
   * 成功信息
   **/
  public String successMsg;

  public CommandResult(int result, String successMsg, String errorMsg) {
    this.result = result;
    this.successMsg = successMsg;
    this.errorMsg = errorMsg;
  }

}