package com.project.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import net.coobird.thumbnailator.Thumbnails;

public class UploadFileUtils {
	
	 static final int THUMB_WIDTH = 300;
	 static final int THUMB_HEIGHT = 300;
	 
	 public static String fileUpload(String uploadPath,String fileName, 
			 byte[] fileData, String ymdPath) throws Exception {

		  UUID uid = UUID.randomUUID(); //파일명 중복되지않게 랜덤설정
		  
		  String newFileName = uid + "_" + fileName;
		  String imgPath = uploadPath + ymdPath;
	
		  File target = new File(imgPath, newFileName);
		  FileCopyUtils.copy(fileData, target);
		  
		  String thumbFileName = "s_" + newFileName;
		  File image = new File(imgPath + File.separator + newFileName);
		  //separator 파일경로 설정 시 OS에 따라서 디렉토리사이에 표시해주는 구분자
	
		  File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);
	
		  if (image.exists()) {
		   thumbnail.getParentFile().mkdirs();
		   //만들고자 하는 디렉토리의 상위 디렉토리가 존재하지 않을 경우, 상위 디렉토리까지 생성
		   Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		  }
		  return newFileName;
	 }

	 //년월일 폴더생성 +썸네일폴더(s)
	 public static String calcPath(String uploadPath) {
		  Calendar cal = Calendar.getInstance();
		  String yearPath = File.separator + cal.get(Calendar.YEAR);
		  String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		  String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
	
		  makeDir(uploadPath, yearPath, monthPath, datePath);
		  makeDir(uploadPath, yearPath, monthPath, datePath + "\\s");
	
		  return datePath;
	 }

	 private static void makeDir(String uploadPath, String... paths) {

		  if (new File(paths[paths.length - 1]).exists()) { return; }
	
		  for (String path : paths) {
			   File dirPath = new File(uploadPath + path);
		
			   if (!dirPath.exists()) {
			    dirPath.mkdir();
			   }
		  }
	 }
}
