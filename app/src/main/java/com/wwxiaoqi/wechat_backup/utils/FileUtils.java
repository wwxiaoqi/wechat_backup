package com.wwxiaoqi.wechat_backup.utils;

import android.content.res.AssetManager;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 文件处理工具类
 */
public class FileUtils {

  /***
   * 复制 AssetManager 文件到指定位置
   * @param assetManager AssetManager
   * @param fileDir 文件路径
   * @param name 文件名称
   */
  public static void copyAssetManagerFiles(AssetManager assetManager, File fileDir, String name) {
    try {
      File file = new File(fileDir, name);
      InputStream open = assetManager.open(name);
      FileOutputStream fileOutputStream = new FileOutputStream(file);
      org.apache.commons.io.IOUtils.copy(open, fileOutputStream);
      open.close();
      fileOutputStream.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  /***
   * 判断文件是否存在
   * @param filePath 文件路径
   * @return boolean 存在 true，不存在 false
   */
  public static boolean fileIsExists(String filePath) {
    try {
      File file = new File(filePath);
      if (!file.exists()) {
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    return true;
  }

  /***
   * 获取目录下所有文件(按时间排序)
   * @param path 文件夹路径
   * @return List<File> 列表
   */
  public static List<File> getFileSort(String path) {
    List<File> list = getFiles(path, new ArrayList<>());
    if (list.size() > 0) {
      Collections.sort(list, (file, newFile) -> Long.compare(newFile.lastModified(), file.lastModified()));
    }
    return list;
  }

  /***
   * 获取目录下所有文件
   * @param ralph 文件夹路径
   * @param files List<File> 列表
   * @return List<File>
   */
  public static List<File> getFiles(String ralph, List<File> files) {
    File realFile = new File(ralph);
    if (realFile.isDirectory()) {
      File[] subsides = realFile.listFiles();
      assert subsides != null;
      for (File file : subsides) {
        if (file.isDirectory()) {
          getFiles(file.getAbsolutePath(), files);
        } else {
          files.add(file);
        }
      }
    }
    return files;
  }

  /***
   * 替换指定文件中的指定内容
   * @param filepath  文件路径
   * @param sourceStr 文件需要替换的内容
   * @param targetStr 替换后的内容
   * @return 替换成功返回 true，否则返回 false
   */
  public static boolean replaceFileStr(String filepath, String sourceStr, String targetStr) {
    try {
      FileReader fileReader = new FileReader(filepath);
      char[] data = new char[1024];
      int rn;
      StringBuilder stringBuilder = new StringBuilder();
      while ((rn = fileReader.read(data)) > 0) {
        String str = String.valueOf(data, 0, rn);
        System.out.println(str);
        stringBuilder.append(str);
      }
      fileReader.close();
      String str = stringBuilder.toString().replaceAll(sourceStr, targetStr);
      FileWriter flout = new FileWriter(filepath);
      flout.write(str.toCharArray());
      flout.close();
      return true;
    } catch (IOException e) {
      e.printStackTrace();
      return false;
    }
  }

}
