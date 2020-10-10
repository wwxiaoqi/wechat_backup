package com.wwxiaoqi.wechat_backup.utils

import android.content.res.AssetManager
import org.apache.commons.io.IOUtils
import java.io.*
import java.util.*

/**
 * 文件处理工具类
 */
object FileUtils {
  /***
   * 复制 AssetManager 文件到指定位置
   * @param assetManager AssetManager
   * @param fileDir 文件路径
   * @param name 文件名称
   */
  fun copyAssetManagerFiles(assetManager: AssetManager, fileDir: File, name: String) {
    try {
      val file = File(fileDir, name)
      val open = assetManager.open(name)
      val fileOutputStream = FileOutputStream(file)
      IOUtils.copy(open, fileOutputStream)
      open.close()
      fileOutputStream.close()
    } catch (e: IOException) {
      e.printStackTrace()
    }
  }

  /***
   * 判断文件是否存在
   * @param filePath 文件路径
   * @return boolean 存在 true，不存在 false
   */
  fun fileIsExists(filePath: String): Boolean {
    try {
      val file = File(filePath)
      if (!file.exists()) {
        return false
      }
    } catch (e: Exception) {
      e.printStackTrace()
      return false
    }
    return true
  }

  /***
   * 获取目录下所有文件(按时间排序)
   * @param path 文件夹路径
   * @return List<File> 列表
   */
  fun getFileSort(path: String): List<File> {
    val list = getFiles(path, ArrayList())
    if (list.isNotEmpty()) {
      Collections.sort(list) { file: File, newFile: File -> newFile.lastModified().compareTo(file.lastModified()) }
    }
    return list
  }

  /***
   * 获取目录下所有文件
   * @param ralph 文件夹路径
   * @param files List<File> 列表
   * @return List<File>
   */
  private fun getFiles(ralph: String, files: MutableList<File>): List<File> {
    val realFile = File(ralph)
    if (realFile.isDirectory) {
      val subsides = realFile.listFiles()!!
      for (file in subsides) {
        if (file.isDirectory) {
          getFiles(file.absolutePath, files)
        } else {
          files.add(file)
        }
      }
    }
    return files
  }

  /***
   * 替换指定文件中的指定内容
   * @param filepath  文件路径
   * @param sourceStr 文件需要替换的内容
   * @param targetStr 替换后的内容
   * @return 替换成功返回 true，否则返回 false
   */
  fun replaceFileStr(filepath: String, sourceStr: String, targetStr: String): Boolean {
    return try {
      val fileReader = FileReader(filepath)
      val data = CharArray(1024)
      var rn: Int
      val stringBuilder = StringBuilder()
      while (fileReader.read(data).also { rn = it } > 0) {
        val str = String(data, 0, rn)
        println(str)
        stringBuilder.append(str)
      }
      fileReader.close()
      val str = stringBuilder.toString().replace(sourceStr.toRegex(), targetStr)
      val flout = FileWriter(filepath)
      flout.write(str.toCharArray())
      flout.close()
      true
    } catch (e: IOException) {
      e.printStackTrace()
      false
    }
  }
}