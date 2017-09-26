package paasta.delivery.pipeline.ui.file;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.io.IOException;
import java.util.List;

/**
 * Created by hrjin on 2017-06-12.
 */
@Service
public class FileService {

//    private static final Logger LOGGER = LoggerFactory.getLogger(FileService.class);

    private static final String REQ_URL = "/file";
    private final RestTemplateService restTemplateService;

    @Autowired
    public FileService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     *
     *  MultipartFile 을 업로드 ::: Swift Object Storage
     *
     * @param multipartFile
     * @return
     * @throws IOException
     */
    public FileInfo upload(MultipartFile multipartFile) throws Exception {
        return restTemplateService.sendMultipart(Constants.TARGET_BINARY_STORAGE_API, REQ_URL + "/uploadFile", multipartFile, FileInfo.class);
    }

    public List<FileInfo> getFileList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }

    public FileInfo getFileInfo(Long fileId) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + fileId, HttpMethod.GET, null, FileInfo.class);
    }


    public FileInfo deleteFile(long fileId) {
        FileInfo deleteFile = getFileInfo(fileId);

        restTemplateService.send(Constants.TARGET_BINARY_STORAGE_API, REQ_URL + "/fileDelete", HttpMethod.POST, deleteFile, String.class);

        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + fileId, HttpMethod.DELETE, null, String.class);
        FileInfo resultModel = new FileInfo();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return resultModel;
    }


}
