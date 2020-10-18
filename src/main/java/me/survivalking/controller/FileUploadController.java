package me.survivalking.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import me.survivalking.domain.BoardAttachVO;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j
public class FileUploadController {
	private String getFolder() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = dateFormat.format(date);
		
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());		

			return contentType.startsWith("image");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<BoardAttachVO> list = new ArrayList<>();
		
		String uploadFolder = "D:\\Spring_Pjt\\upload\\temp";
		
		String uploadFolderPath = getFolder();
		
		// make folder
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		// yyyy/MM/dd 이름으로 파일 생성
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile file : uploadFile) {
			BoardAttachVO  boardAttachVO = new BoardAttachVO();
			
			String uploadFileName = file.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			boardAttachVO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				
				file.transferTo(saveFile);
				
				boardAttachVO.setUuid(uuid.toString());
				boardAttachVO.setUploadPath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					boardAttachVO.setFileType(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				
				// list에 추가
				list.add(boardAttachVO);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		//log.info("Display File Name : " + fileName);
		
		File file = new File("D:\\Spring_Pjt\\upload\\temp\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	} // end of getFile
	
	@GetMapping(value="/download", produces= MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,  String fileName){
		
		Resource resource = new FileSystemResource("D:\\Spring_Pjt\\upload\\temp\\" + fileName);
		
		//log.info(resource);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		//removeUUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		//log.info("리소스 명 : " + resourceOriginalName);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE Browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
			}
			else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
			}
			else {
				log.info("Chrome Browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		}
		catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("Authenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		File file;
		
		try {
			file = new File("D:\\Spring_Pjt\\upload\\temp\\" + URLDecoder.decode(fileName,"UTF-8"));
			
			//log.info("deleteFile2: " + file.getAbsolutePath());
			
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				//log.info("lageFileName : " + largeFileName);
				
				file = new File(largeFileName);
				
				if(file.exists()) file.delete();
			}
		}
		catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("Deleted", HttpStatus.OK);
	}
}
