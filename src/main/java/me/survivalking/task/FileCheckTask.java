package me.survivalking.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardAttachVO;
import me.survivalking.mapper.BoardAttachMapper;

@Component
@Log4j
public class FileCheckTask {
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		
		String str = dateFormat.format(cal.getTime());
		
		return str.replace("-", File.separator);	
	}
	
	@Scheduled(cron = "0 * * * * *")
	public void checkFiles() throws Exception{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date date = new Date();
		String str = dateFormat.format(date);
		
		//fileList in database
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		if(fileList == null || fileList.isEmpty()) return;
		
		// Path List 구성
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("D:\\Spring_Pjt\\upload\\temp", vo.getUploadPath(), 
				                                         vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		
		// Thumb nail file 제거 리스트에 추가
		fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("D:\\Spring_Pjt\\upload\\temp", vo.getUploadPath(), 
                "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));
		
		// yesterday file
		File targetDir = Paths.get("D:\\Spring_Pjt\\upload\\temp", getFolderYesterDay()).toFile();
		
		// fileListPaths에는 없는 파일만 삭제
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		for(File file : removeFiles) {
			file.delete(); // DB에 경로가 없는 파일 삭제
		}
		
		return;
	}
	// end of checkFiles function
	
}

