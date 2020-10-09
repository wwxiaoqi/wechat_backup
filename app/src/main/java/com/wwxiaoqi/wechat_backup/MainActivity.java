package com.wwxiaoqi.wechat_backup;

import android.app.AlertDialog;
import android.os.Bundle;
import android.view.View;
import androidx.appcompat.app.AppCompatActivity;
import com.wwxiaoqi.wechat_backup.base.AppConst;
import com.wwxiaoqi.wechat_backup.thread.BackupThread;
import com.wwxiaoqi.wechat_backup.thread.RestoreThread;
import com.wwxiaoqi.wechat_backup.utils.AppUtils;
import com.wwxiaoqi.wechat_backup.utils.FileUtils;
import com.wwxiaoqi.wechat_backup.utils.PermissionUtils;
import java.io.File;
import java.util.List;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    init();
    initPermission();
    initView();
  }

  private void init() {
    if (AppUtils.isFirstRunApp(this)) {
      FileUtils.copyAssetManagerFiles(getAssets(), getFilesDir(), "backup.sh");
      FileUtils.copyAssetManagerFiles(getAssets(), getFilesDir(), "recovery.sh");
    }
  }

  private void initPermission() {
    PermissionUtils.verifyStoragePermissions(this);
  }

  private void initView() {
    findViewById(R.id.btn_backup).setOnClickListener(this);
    findViewById(R.id.btn_restore).setOnClickListener(this);
  }

  @Override public void onClick(View view) {
    switch (view.getId()) {
      case R.id.btn_backup:
        run_backup();
        break;
      case R.id.btn_restore:
        run_restore();
        break;
    }
  }

  private void run_restore() {
    List<File> list = FileUtils.getFileSort(AppConst.WECHAT_BACKUP_PATH);
    String[] array = new String[list.size()];
    int index = 0;
    for (File value : list) {
      array[index] = value.getName();
      index++;
    }

    AlertDialog.Builder builder = new AlertDialog.Builder(this);
    builder.setItems(array, (dialog, which) -> {

      String options = array[which];
      options = options.replace(AppConst.WECHAT_BACKUP_EXTENSION_NAME, "");

      FileUtils.replaceFileStr(
          getFilesDir() + "/recovery.sh",
          "recovery_date=\"(.*)\"",
          "recovery_date=\"" + options + "\""
      );

      RestoreThread restoreThread = new RestoreThread(this, getFilesDir());
      restoreThread.start();
    });
    builder.show();
  }

  private void run_backup() {
    BackupThread backupThread = new BackupThread(this, getFilesDir());
    backupThread.start();
  }

}