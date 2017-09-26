package paasta.delivery.pipeline.ui.file;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.List;

/**
 * Created by hrjin on 2017-06-12.
 */
@RestController
@RequestMapping(value = "/dashboard/{suid}")
public class FileController {

    private static  final Logger logger = LoggerFactory.getLogger(FileController.class);
    private static final String BASE_URL = "/file";

    @Autowired
    private FileService fileService;


    /**
     *  파일 업로드 - page
     *
     * @return upload File page
     */
    @RequestMapping(value = {BASE_URL + "/upload"}, method = RequestMethod.GET)
    public ModelAndView upload(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName(BASE_URL + "/fileUpload");
        return mv;
    }


    /**
     *  업로드된 파일 리스트 받아오기 - page
     *
     * @return Get File List
     */
    @RequestMapping(value = {BASE_URL + "/info"}, method = RequestMethod.GET)
    public ModelAndView getFileList(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("fileInfo", fileService.getFileList());
        mv.setViewName(BASE_URL + "/fileInfo");
        return mv;
    }


    /**
     *  업로드된 파일 상세 정보 - page
     *
     * @return Get File Info
     */
    @RequestMapping(value = {BASE_URL + "/info/{id}"}, method = RequestMethod.GET)
    public ModelAndView getFileInfo(@PathVariable("id") long id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.setViewName(BASE_URL + "/fileInfoDetail");
        return mv;
    }



    /**
     *  파일 업로드 - execute
     *
     * @param multipartFile
     * @return file upload
     * @throws Exception
     */
    @RequestMapping(value = {BASE_URL + "/uploadFile.do"}, method = RequestMethod.POST)
    @ResponseBody
    public FileInfo uploadFile(@RequestParam("file") MultipartFile multipartFile) throws Exception{
        logger.info("uploadFile :: param:: {}", multipartFile.toString());

        return fileService.upload(multipartFile);
    }



    /**
     *  업로드된 파일 리스트 받아오기 - execute
     *
     * @return Get File List
     */
    @RequestMapping(value = {BASE_URL + "/getFileList.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List<FileInfo> uploadedFileList(){
        return fileService.getFileList();
    }


    /**
     *  업로드된 파일 상세 정보 - execute
     *
     * @param fileInfo
     * @return Get File Info
     */
    @RequestMapping(value = {BASE_URL + "/getFileInfo.do"}, method = RequestMethod.POST)
    @ResponseBody
    public FileInfo uploadedFileInfo(@RequestBody FileInfo fileInfo){
        return fileService.getFileInfo(fileInfo.getId());
    }


    /**
     * 업로드된 파일 삭제 - execute
     *
     * @param fileInfo
     * @return
     */
    @RequestMapping(value = {BASE_URL + "/fileDelete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public FileInfo deleteFile(@RequestBody FileInfo fileInfo){
        return fileService.deleteFile(fileInfo.getId());
    }


    /**
     *  파일 다운로드 - execute
     *
     * @param
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = {BASE_URL + "/download/{id}"}, method = RequestMethod.GET)
    @ResponseBody
    public void downloadFile(@PathVariable("id") long id , HttpServletResponse response) throws Exception{

        //MultipartFile downloadFile = fileService.downloadFile(storedFileName);

        FileInfo fileInfo = fileService.getFileInfo(id);

        // MIME Type 을 application/octet-stream 타입으로 변경
        // 무조건 팝업(다운로드창)이 뜨게 된다.
        response.setContentType("application/octet-stream");

        // 브라우저는 ISO-8859-1을 인식하기 때문에
        // UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.
        String fileNameForBrowser = new String(fileInfo.getOriginalFileName().getBytes("UTF-8"), "iso-8859-1");

        // 파일명 지정
        response.setHeader("Content-Disposition", "attachment; filename=\""+fileNameForBrowser+"\"");

        OutputStream os = response.getOutputStream();
        InputStream is = new URL(fileInfo.getFileUrl()).openStream();

        int n = 0;
        byte[] b = new byte[512];
        while((n = is.read(b)) != -1 ) {
            os.write(b, 0, n);
        }
        is.close();
        os.close();

    }

}
