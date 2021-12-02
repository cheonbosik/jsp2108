package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsDownLoadCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getPdsContent(idx);
		
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		ServletOutputStream sos = null;
		
		String realPath = request.getServletContext().getRealPath("/data/pds/");
		String zipPath = request.getServletContext().getRealPath("/data/pds/temp/");
		String zipName = vo.getTitle() + ".zip";
		fos = new FileOutputStream(zipPath + zipName);
		
		zos = new ZipOutputStream(fos);
		
		byte[] b = new byte[2048];
		int data = 0;
		
		// 다운로드시에 압축된 파일안에 중복된 이름의 파일이 존재할경우에 다음과 같이 편집한다.
		// 1.jpg/1.jpg/1.jpg  ==>> 1.jpg/1(1).jpg/1(2).jpg
		for(int i=0; i<fNames.length; i++) {
			for(int j=0; j<i; j++) {
				if(fNames[i].equals(fNames[j])) {
					fNames[i] = fNames[i].substring(0,fNames[i].lastIndexOf(".")) + "("+i+")" + fNames[i].substring(fNames[i].length()-4);
					break;
				}
			}
		}
		
		for(int i=0; i<fSNames.length; i++) {
			File file = new File(realPath + fSNames[i]);
			//File moveAndRename = new File(zipName + fSNames[i]);
			File moveAndRename = new File(realPath+fNames[i]);
			
			file.renameTo(moveAndRename);
			
			fis = new FileInputStream(moveAndRename);
			//zos.putNextEntry(new ZipEntry(fSNames[i]));
			zos.putNextEntry(new ZipEntry(fNames[i]));
			
			while((data = fis.read(b,0,b.length)) != -1) {
				zos.write(b,0,data);
			}
			zos.flush();
			zos.closeEntry();
			fis.close();
			
			//moveAndRename.renameTo(file);
		}
		zos.close();
		
		// 앞의 작업을 마치게되면 개별파일들이 압축파일로 묶여있게된다. 따라서, 1개의 압축파일을 클라이언트에 다운로드 시켜준다.
		// header에 정보를 담아주기위한 처리부
		String mimeType = request.getServletContext().getMimeType(zipName.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downLoadName = new String(zipName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downLoadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		}
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName);
		
		fis = new FileInputStream(zipPath + zipName);
		sos = response.getOutputStream();
		
		while((data = fis.read(b, 0, b.length)) != -1) {
			sos.write(b, 0, data);
		}
		sos.flush();
		
		sos.close();
		fis.close();
		
		// 다운로드 완료후 통합작업된 압축파일을 삭제처리한다.
		new File(zipPath + zipName).delete();
		
		// 자료 다운로드수 증가하기
		dao.setPdsDownUpdate(idx);
	}

}
