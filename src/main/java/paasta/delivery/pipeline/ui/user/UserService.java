package paasta.delivery.pipeline.ui.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.user
 *
 * @author REX
 * @version 1.0
 * @since 5/17/2017
 */
@Service
public class UserService {

    private static final String REQ_URL = "/user";
    private final RestTemplateService restTemplateService;

    @Autowired
    public UserService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    public UserList getUserList(String queryString) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + queryString , HttpMethod.GET, null, UserList.class);
    }

    public User getUser(String userId) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + userId, HttpMethod.GET, null, User.class);
    }


    public User setCreateUser(User user) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, user, User.class);
    }


    public User setUpdateUser(User user) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + user.getId(), HttpMethod.PUT, user, User.class);
    }


    public User setDeleteUser(String userId) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + userId, HttpMethod.DELETE, null, String.class);
        User resultModel = new User();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return resultModel;
    }

    // TODO 임시 메소드
    public User findByName(String name) {
        return null;
    }
}
